//
//  PreferencesTabelCell.swift
//  Ouro
//
//  Created by PC on 22/10/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit

class PreferencesTabelCell: UITableViewCell {

    @IBOutlet weak var lblfinalMiles: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var btnSavePreferences: ButtonView!
    @IBOutlet weak var lblMiles: UILabel!
    @IBOutlet weak var btnIncreseMiles: UIButton!
    @IBOutlet weak var btnDecreseMiles: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        let titleTextAttributes1 = [NSAttributedString.Key.foregroundColor: UIColor.white]
     segmentedControl.setTitleTextAttributes(titleTextAttributes1, for: .normal)
     segmentedControl.setTitleTextAttributes(titleTextAttributes, for: .selected)        
    }
    
    @IBAction func segmentcontrol(_ sender: Any) {
        let sortedViews = segmentedControl.subviews.sorted( by: { $0.frame.origin.x < $1.frame.origin.x } )

        for (index, view) in sortedViews.enumerated() {
            if index == segmentedControl.selectedSegmentIndex {
                view.tintColor = UIColor.white
            
            } else {
               
                view.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            }
        }
    }
}
