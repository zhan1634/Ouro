//
//  ViewPreferencesDetailVC.swift
//  Ouro
//
//  Created by PC on 22/10/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit
import Firebase



class ViewPreferencesDetailVC: BaseViewController {

    @IBOutlet weak var imgrestaurant: UIImageView!
    
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Address: UILabel!
    @IBOutlet weak var Price: UIButton!
    @IBOutlet weak var Date: UIButton!
    @IBOutlet weak var Cuisine: UIButton!
    @IBOutlet weak var CheckIn: ButtonView!
    
    var resultDictGenerated = [String:Any]()
    var ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(resultDictGenerated)
        Name.text = resultDictGenerated["Name"] as? String
        Address.text = resultDictGenerated["Address"] as? String
        Price.setTitle(resultDictGenerated["Price"] as? String, for: .normal)
//        Cuisine.text = "Italian"
//        Date.text = "April 13"
        
        Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
                let timestamp = String(Int(NSDate().timeIntervalSince1970))
                self.ref.child("Pending").child(user.uid).child(timestamp).setValue(self.resultDictGenerated)
            } else {
                print("No Logged In User")
            }
        }
        setupnavigation()
        SetImageCornerRadius(imgrestaurant, radius: 20.0)
    }
    
    func setupnavigation()
       {
           SetNavigationTitle(Navname: "OURO")
           setLeftMenubtn(img: "Menu Icon")
           setRightMenubtn(img: "Check In")
       }
}
