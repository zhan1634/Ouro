//
//  popUpGroupSelection.swift
//  Ouro
//
//  Created by Jack Zhang on 2019-04-28.
//  Copyright © 2019 Ouro. All rights reserved.
//

import UIKit

class popUpGroupSelection: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.showAnimate()

    }
    
    // MARK: Animation for Solo Group Selections
    @IBAction func closeGroupSelection(_ sender: Any) {
        self.removeAnimate()
    }
    
    func showAnimate() {
        self.view.transform = CGAffineTransform(scaleX: 1.3,y: 1.3)
        self.view.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
    func removeAnimate() {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.view.alpha = 0.0
        }, completion: { (finished: Bool) in
            if (finished) {
                self.view.removeFromSuperview()
            }
        })
    }
    
    // MARK: Group Selection
//    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
//        if (segue.identifier == "GroupSegue") {
//            // pass data to next view
//        }
//    }
    
    @IBAction func GroupButton(_ sender: Any) {
        performSegue(withIdentifier: "GroupSegue", sender: self)
    }
    
    @IBAction func SoloButton(_ sender: Any) {
        performSegue(withIdentifier: "SoloPreferencesSegue", sender: self)
    }
    
    
}
