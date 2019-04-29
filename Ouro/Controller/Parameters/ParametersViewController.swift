//
//  ParametersViewController.swift
//  Ouro
//
//  Created by Jack Zhang on 2019-04-28.
//  Copyright © 2019 Ouro. All rights reserved.
//

import UIKit

class ParametersViewController: UIViewController, UIGestureRecognizerDelegate {


    override func viewDidLoad() {
        super.viewDidLoad()
        let drag = UITapGestureRecognizer(target: self, action: #selector(ParametersViewController.touch(sender:)))
        drag.numberOfTapsRequired = 1
        view.addGestureRecognizer(drag)

    }
    
    @objc func touch(sender: UITapGestureRecognizer) {
        let point = sender.location(in: self.view)
        let x = point.x
        let y = point.y
        print(x)
        print(y)
    }
    
    @IBAction func PreferencesButtonUp(_ sender: Any) {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "preferencesViewID") as! PreferencesViewController
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
    }

}
