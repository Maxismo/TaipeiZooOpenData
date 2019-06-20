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
        setupUI()
    }
    
    override func prepareForReuse() {
        iconImageView.image = UIImage(named: "unknown")
    }
    
}

private extension PlantTableViewCell {
    func setupUI() {
        iconImageView.layer.cornerRadius = iconImageView.bounds.height / 2
        iconImageView.layer.borderColor = UIColor.gray.cgColor
        iconImageView.layer.borderWidth = 2
    }
    
    func setData() {
        if let url = info.picUrl {
            let request = Request(
                resource: UIImage.init
            )
            
            Client(baseURL: url).perform(request) { result in
                if let image = result as? UIImage {
                    DispatchQueue.main.async { [weak self] in
                        self?.iconImageView.image = image
                    }
                }
            }
        }
        
        nameLabel.text = info.name
        
        locationLabel.text = info.location
        locationLabel.sizeToFit()
        
        featureLabel.text = info.feature
        featureLabel.sizeToFit()
    }
}
