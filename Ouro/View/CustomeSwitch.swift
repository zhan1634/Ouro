//
//  CustomeSwitch.swift
//  Ouro
//
//  Created by PC on 22/10/19.
//  Copyright © 2019 PC. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class UICustomSwitch : UISwitch {

    //MARK: Variables
    var OnColor : UIColor! = UIColor.white
    var OffColor : UIColor! = UIColor.gray
    var Scale : CGFloat! = 1.0

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpCustomUserInterface()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setUpCustomUserInterface()
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet{
            self.layer.borderColor = borderColor?.cgColor
        }
    }
    
    func setUpCustomUserInterface() {

        //clip the background color
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true

        //Scale down to make it smaller in look
        self.transform = CGAffineTransform(scaleX: self.Scale, y: self.Scale);

        //add target to get user interation to update user-interface accordingly
        self.addTarget(self, action: #selector(UICustomSwitch.updateUI), for: UIControl.Event.valueChanged)

        //set onTintColor : is necessary to make it colored
        self.onTintColor = self.OnColor
        

        //setup to initial state
        self.updateUI()
    }

    //to track programatic update
    override func setOn(_ on: Bool, animated: Bool) {
        super.setOn(on, animated: true)
        updateUI()
    }

    //Update user-interface according to on/off state
    @objc func updateUI() {
        if self.isOn == true {
            self.backgroundColor = self.OnColor
        }
        else {
            self.backgroundColor = self.OffColor
        }
    }
}
