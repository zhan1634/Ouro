//
//  UpcomingTableViewCell.swift
//  Ouro
//
//  Created by MyMac on 13/08/19.
//  Copyright © 2019 Ouro. All rights reserved.
//


//EDIT: ******************
import UIKit

class UpcomingTableViewCell: UITableViewCell {
  
  

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
//END EDIT: ******************
