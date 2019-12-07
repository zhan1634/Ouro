//
//  PreferencesSwitchTabelCell.swift
//  Ouro
//
//  Created by PC on 22/10/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit

class PreferencesSwitchTabelCell: UITableViewCell {
    

    @IBOutlet weak var lblPreferncesName: UILabel!
    @IBOutlet weak var lblPreferncesDiscriontion: UILabel!
    @IBOutlet weak var preferncesswitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        preferncesswitch.layer.masksToBounds = true
         preferncesswitch.layer.cornerRadius = 15
        preferncesswitch.layer.borderColor = UIColor.gray.cgColor // <-- we'll add the gray color
        preferncesswitch.layer.borderWidth = 1.0 // controll the w
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
