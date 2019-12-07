//
//  labelview.swift
//  Gretus Receiver
//
//  Created by MyMac on 25/07/19.
//  Copyright © 2019 Zokotech. All rights reserved.
//

import UIKit

class labelview: UILabel {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet
        {
            self.layer.cornerRadius = cornerRadius
        }
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
}
