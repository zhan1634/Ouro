//
//  Utility.swift
//  Ouro
//
//  Created by PC on 21/10/19.
//  Copyright © 2019 PC. All rights reserved.
//

import Foundation
import  UIKit
//MARK: - Get AppStoryboard Extension
enum AppStoryboard : String {
    
    case Main
    case Schedule
    case Home
    case Profile

    var instance : UIStoryboard {
        
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T : UIViewController>(viewControllerClass : T.Type, function : String = #function, line : Int = #line, file : String = #file) -> T {
        
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        
        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            
            fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
        }
        
        return scene
    }
    
    func initialViewController() -> UIViewController? {
        
        return instance.instantiateInitialViewController()
    }
}

extension UIViewController {
    
    // Not using static as it wont be possible to override to provide custom storyboardID then
    class var storyboardID : String {
        
        return "\(self)"
    }
    
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        
        return appStoryboard.viewController(viewControllerClass: self)
    }
}

public func SetImageCornerRadius(_ image:UIImageView,radius:CGFloat)
  {
      image.layer.masksToBounds = true
      image.layer.cornerRadius = radius
      image.clipsToBounds = true
  }

extension UIView {
     
    func removeAnimate() {
        UIView.animate(withDuration: 0.3, animations: {
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.alpha = 0.0
        }, completion: { (finished: Bool) in
            if (finished) {
                //self.willMove(toParent: nil)
                self.removeFromSuperview()
                //self.removeFromParent()
            }
        })
    }
}
