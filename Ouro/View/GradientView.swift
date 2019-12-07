//
//  new.swift
//  Morganic
//
//  Created by MyMAC on 02/05/19.
//  Copyright © 2019 Sagar R. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable
final class GradientView: UIView {
    @IBInspectable var startColor: UIColor = UIColor.clear
    @IBInspectable var endColor: UIColor = UIColor.clear
    
    override func draw(_ rect: CGRect) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = CGRect(x: CGFloat(0),
                                y: CGFloat(0),
                                width: self.frame.size.width,
                                height: self.frame.size.height )
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)

        //gradient.zPosition = -1
        layer.addSublayer(gradient)
    }
}
