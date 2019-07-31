//
//  popUpGroupSelection.swift
//  Ouro
//
//  Created by Jack Zhang on 2019-04-28.
//  Copyright © 2019 Ouro. All rights reserved.
//

import UIKit

class popUpGroupSelection: UIViewController {

    
    @IBOutlet weak var SoloButton: UIButton!
    @IBOutlet weak var GroupButton: UIButton!
    @IBOutlet weak var CancelButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        self.setButtons()
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
                self.willMove(toParent: nil)
                self.view.removeFromSuperview()
                self.removeFromParent()
            }
        })
    }
    
    // MARK: Group Selection
    
    @IBAction func GroupButton(_ sender: Any) {
        performSegue(withIdentifier: "GroupSegue", sender: self)
    }
    
    @IBAction func SoloButton(_ sender: Any) {
        performSegue(withIdentifier: "SoloPreferencesSegue", sender: self)
    }
    
    func setButtons() {
        
        self.view.addSubview(SoloButton)
        self.view.addSubview(GroupButton)
        self.view.addSubview(CancelButton)

        SoloButton.translatesAutoresizingMaskIntoConstraints = false
        GroupButton.translatesAutoresizingMaskIntoConstraints = false
        CancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        SoloButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        SoloButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -45).isActive = true
        SoloButton.heightAnchor.constraint(equalToConstant: 65.0).isActive = true
        SoloButton.widthAnchor.constraint(equalToConstant: 215).isActive = true
        
        GroupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        GroupButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 45).isActive = true
        GroupButton.heightAnchor.constraint(equalToConstant: 65.0).isActive = true
        GroupButton.widthAnchor.constraint(equalToConstant: 215).isActive = true

        
        CancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        CancelButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 115).isActive = true
        CancelButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        CancelButton.widthAnchor.constraint(equalToConstant: 120).isActive = true

    }
    
}
