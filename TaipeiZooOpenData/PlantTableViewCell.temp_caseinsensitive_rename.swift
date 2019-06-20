//
//  plantTableViewCell.swift
//  TaipeiZooOpenData
//
//  Created by Max Chen on 6/19/19.
//  Copyright © 2019 NotAnOrganization. All rights reserved.
//

import UIKit

class PlantTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var featureLabel: UILabel!
    
    var info: Plant! {
        didSet {
            setData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        iconImageView.image = UIImage(named: "mint")
    }
    
}

private extension PlantTableViewCell {
    func setData() {
        nameLabel.text = info.name
        locationLabel.text = info.location
        featureLabel.text = info.feature
    }
}
