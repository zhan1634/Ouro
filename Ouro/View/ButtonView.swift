//
//  ButtonView.swift
//  MyTraininfo
//
//  Created by MyMac on 08/07/19.
//  Copyright © 2019 MyMac. All rights reserved.
//

import UIKit

class ButtonView: UIButton {
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
    
    @IBInspectable var shadowColor: UIColor? {
        
        didSet {
            self.layer.shadowColor = shadowColor?.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.0 {
        didSet{
            self.layer.shadowOpacity = shadowOpacity
        }
    }

}
