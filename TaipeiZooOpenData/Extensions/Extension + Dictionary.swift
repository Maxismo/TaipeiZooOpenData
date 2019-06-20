//
//  Extension + Dictionary.swift
//  TaipeiZooOpenData
//
//  Created by Max Chen on 6/19/19.
//  Copyright © 2019 NotAnOrganization. All rights reserved.
//

import Foundation

extension Dictionary {
    
    var jsonString: String {
        guard let json = try? JSONSerialization.data(withJSONObject: self, options: []) else { return "" }
        guard let string = String(data: json, encoding: .utf8) else { return "" }
        return string
    }
}
