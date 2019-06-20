//
//  Client.swift
//  TaipeiZooOpenData
//
//  Created by Max Chen on 6/19/19.
//  Copyright © 2019 NotAnOrganization. All rights reserved.
//

import Foundation

struct Client {
    
    let baseURL: String
    let session: URLSession
    
    init(baseURL: String, session: URLSession = URLSession.shared) {
        self.baseURL = baseURL
        self.session = session
    }
    
    private func prepare<Resource>(_ request: Request<Resource>) -> URLRequest? {
        guard let url = URL(string: self.baseURL + request.path) else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        let headers = request.headers ?? [:]
        headers.forEach { (arg) in
            let (key, value) = arg
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        
        if let parameters = request.parameters {
            urlRequest = parameters.apply(to: urlRequest)
        }
        
        return urlRequest
    }
    
    func perform<Resource>(_ request: Request<Resource>, completion: @escaping (Resource?) -> Void) {
        
        guard let urlRequest = prepare(request) else { return }
        
        let task = self.session.dataTask(with: urlRequest) { (data, urlResponse, error) in
            guard let urlResponse = urlResponse as? HTTPURLResponse else {
                if let error = error {
                    print(error)
                } else {
                    print("Did not receive HTTPURLResponse.")
                }
                completion(nil)
                return
            }
            
            if let error = error {
                print(error)
                print(urlResponse.statusCode)
                completion(nil)
            }
            
            guard (200..<300).contains(urlResponse.statusCode) else {
                print("Validation failed: HTTP status code \(urlResponse.statusCode).")
                completion(nil)
                return
            }
            
            if let data = data {
                do {
                    let resource = try request.resource(data)
                    completion(resource)
                } catch let error {
                    print(error)
                    completion(nil)
                }
            } else {
                // no error, no data - valid empty response
                completion(nil)
            }
        }
        
        task.resume()
    }
}
