//
//  RestaurantheaderCell.swift
//  Ouro
//
//  Created by PC on 22/10/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit

class RestaurantheaderCell: UITableViewCell {

    @IBOutlet weak var lblCheckIn: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var flag:Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        let titleTextAttributes1 = [NSAttributedString.Key.foregroundColor: UIColor.white]
        segmentedControl.setTitleTextAttributes(titleTextAttributes1, for: .normal)
        segmentedControl.setTitleTextAttributes(titleTextAttributes, for: .selected)
    }
   
    
}
