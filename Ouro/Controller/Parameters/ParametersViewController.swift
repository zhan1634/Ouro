//
//  ParametersViewController.swift
//  Ouro
//
//  Created by Jack Zhang on 2019-04-28.
//  Copyright © 2019 Ouro. All rights reserved.
//

import UIKit

class ParametersViewController: UIViewController, UIGestureRecognizerDelegate {

    var currentScroll = CGFloat()
    var verticalShift = CGFloat()
    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "preferencesViewID") as! PreferencesViewController

    
    //        popOverVC.view.frame = self.view.frame
    //        self.view.addSubview(popOverVC.view)
    //        popOverVC.didMove(toParent: self)
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let drag = UIPanGestureRecognizer(target: self, action: #selector(ParametersViewController.touch(sender:)))
        view.addGestureRecognizer(drag)
        
        popOverVC.view.frame = CGRect(x: 0, y: self.view.frame.maxY * (5/6), width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(popOverVC.view)
        currentScroll = self.view.frame.maxY * (5/6)

    }

    @objc func touch(sender: UIPanGestureRecognizer) {

        let translation = sender.translation(in: self.view)
        
        if sender.state == UIGestureRecognizer.State.began {
        
            currentScroll = popOverVC.view.frame.minY
            
        } else if sender.state == UIGestureRecognizer.State.changed {
            
            verticalShift = currentScroll + translation.y
            
            if verticalShift > (self.view.frame.maxY * (5/6)) {
                verticalShift = self.view.frame.maxY * (5/6)
            } else if verticalShift <= (self.view.frame.minY) {
                verticalShift = self.view.frame.minY
            }

            self.popOverVC.view.frame = CGRect(x: 0, y: verticalShift, width: self.view.frame.width, height: self.view.frame.height)

        } else if sender.state == UIGestureRecognizer.State.ended {
            print(self.popOverVC.view.frame.minY)
            print(self.view.frame.maxY * (4/6))
            
            if self.popOverVC.view.frame.minY <= (self.view.frame.maxY * (3/6)) {
                print("YES")
                UIView.animate(withDuration: 0.5) {
                    self.popOverVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
                }
//                self.addChild(popOverVC)
            } else {
                UIView.animate(withDuration: 0.5) {
                    self.popOverVC.view.frame = CGRect(x: 0, y: self.view.frame.maxY * (5/6), width: self.view.frame.width, height: self.view.frame.height)
                }
            }
        }

    }
    
    @IBAction func PreferencesButtonUp(_ sender: Any) {
        
        
    }

}
