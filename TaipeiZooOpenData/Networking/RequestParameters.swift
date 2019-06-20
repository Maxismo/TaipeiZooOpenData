//
//  RequestParameters.swift
//  TaipeiZooOpenData
//
//  Created by Max Chen on 6/19/19.
//  Copyright © 2019 NotAnOrganization. All rights reserved.
//

import Foundation

protocol RequestParameters {
    func apply(to urlRequest: URLRequest) -> URLRequest
}

struct QueryParameters: RequestParameters {
    
    public let query: [String: String]
    
    public init(_ query: [String: String]) {
        self.query = query
    }
    
    public func apply(to urlRequest: URLRequest) -> URLRequest {
        var request = urlRequest
        var urlComponents = URLComponents(url: request.url!, resolvingAgainstBaseURL: false)!
        var items = urlComponents.queryItems ?? []
        items.append(contentsOf: query.map { URLQueryItem(name: $0.key, value: $0.value) })
        urlComponents.queryItems = items
        request.url = urlComponents.url
        return request
    }
}
