//
//  Restaurant Cell.swift
//  Ouro
//
//  Created by PC on 22/10/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit

class RestaurantCell: UITableViewCell {
    
    
    @IBOutlet weak var lblRestaurantName: UILabel!
    @IBOutlet weak var lblRestaurantDate: UILabel!
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
