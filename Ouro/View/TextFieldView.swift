//
//  TextFieldView.swift
//  MyTraininfoTests
//
//  Created by MyMac on 08/07/19.
//  Copyright © 2019 MyMac. All rights reserved.
//

import UIKit

class TextFieldView: UITextField {
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
    
    let padding = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 5)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
