//
//  Plant.swift
//  TaipeiZooOpenData
//
//  Created by Max Chen on 6/19/19.
//  Copyright © 2019 NotAnOrganization. All rights reserved.
//

import Foundation

struct Plant: Decodable {
    var name: String?
    var location: String?
    var feature: String?
    var picUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "F_Name_Ch"
        case location = "F_Location"
        case feature = "F_Feature"
        case picUrl = "F_Pic01_URL"
    }
}
