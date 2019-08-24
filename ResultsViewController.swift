//
//  ResultsViewController.swift
//  Ouro
//
//  Created by Jack Zhang on 2019-05-10.
//  Copyright © 2019 Ouro. All rights reserved.
//

import UIKit
import Firebase

class ResultsViewController: UIViewController {

    var resultDictGenerated = NSDictionary()
    var ref = Database.database().reference()
    
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Address: UILabel!
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var Cuisine: UILabel!
    @IBOutlet weak var Date: UILabel!
    @IBOutlet weak var CheckIn: UIButton!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        Name.text = resultDictGenerated["Name"] as? String
        Address.text = resultDictGenerated["Address"] as? String
        Price.text = resultDictGenerated["Price"] as? String
        Cuisine.text = "Italian"
        Date.text = "April 13"
        
        Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
                let timestamp = String(Int(NSDate().timeIntervalSince1970))
                self.ref.child("Pending").child(user.uid).child(timestamp).setValue(self.resultDictGenerated)
            } else {
                print("No Logged In User")
            }
        }
    }
    
    @IBOutlet weak var PhonePressed: UIImageView!
    @IBOutlet weak var DirectionsPressed: UIImageView!
    @IBOutlet weak var HoursPressed: UIImageView!
    
    
    @IBAction func CheckInSegue(_ sender: Any) {
        let listVc = UIStoryboard(name: "Restaurant", bundle: nil).instantiateViewController(withIdentifier: "RestaurantListSegmnetPagerVC") as! RestaurantListSegmnetPagerVC
        self.present(listVc, animated: true, completion: {
            
        })
    }

}
