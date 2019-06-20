//
//  Extension + UITableViewCell.swift
//  TaipeiZooOpenData
//
//  Created by Max Chen on 6/19/19.
//  Copyright © 2019 NotAnOrganization. All rights reserved.
//

import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
