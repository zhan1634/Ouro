//
//  myView.swift
//  MyTraininfoTests
//
//  Created by MyMac on 08/07/19.
//  Copyright © 2019 MyMac. All rights reserved.
//

import UIKit

class myView: UIView {
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
