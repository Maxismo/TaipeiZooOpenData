//
//  Request.swift
//  TaipeiZooOpenData
//
//  Created by Max Chen on 6/19/19.
//  Copyright © 2019 NotAnOrganization. All rights reserved.
//

import Foundation

struct Request<Resource> {
    var path: String
    var method: HTTPMethod
    var headers: [String: String]?
    var parameters: RequestParameters?
    var resource: (Data) throws -> Resource
    
    init(path: String = "",
         method: HTTPMethod = .get,
         parameters: RequestParameters? = nil,
         headers: [String: String]? = nil,
         resource: @escaping (Data) throws -> Resource) {
        
        self.path = path
        self.method = method
        self.parameters = parameters
        self.headers = headers
        self.resource = resource
    }
}
