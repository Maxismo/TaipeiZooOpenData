//
//  APIResponse.swift
//  TaipeiZooOpenData
//
//  Created by Max Chen on 6/19/19.
//  Copyright © 2019 NotAnOrganization. All rights reserved.
//

import Foundation

struct APIResponse<T: Decodable>: Decodable {
    var result: APIResult<T>
    
    init(json: Data) throws {
        do {
            self = try JSONDecoder().decode(APIResponse.self, from: json)
        } catch {
            throw error
        }
    }
}

struct APIResult<T: Decodable>: Decodable {
    var limit: Int
    var offset: Int
    var count: Int
    var sort: String
    var results: [T]
}
