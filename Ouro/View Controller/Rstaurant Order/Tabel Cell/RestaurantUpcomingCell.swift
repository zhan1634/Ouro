//
//  RestaurantUpcomingCell.swift
//  Ouro
//
//  Created by PC on 24/10/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit

class RestaurantUpcomingCell: UITableViewCell {
    
    @IBOutlet weak var btnRestaurantName: UIButton!
    @IBOutlet weak var btndate: UIButton!
    @IBOutlet weak var imgRestaurant: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
