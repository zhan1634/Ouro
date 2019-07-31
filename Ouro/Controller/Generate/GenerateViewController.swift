//
//  GenerateViewController.swift
//  Ouro
//
//  Created by Jack Zhang on 2019-05-02.
//  Copyright © 2019 Ouro. All rights reserved.
//

import UIKit
import Firebase
import GeoFire

class GenerateViewController: UIViewController {

    @IBOutlet weak var BlueShadow: UIImageView!
    
    var ref = Database.database().reference().child("Restaurants")
    var geoFire = GeoFire(firebaseRef: Database.database().reference().child("Locations"))
    var users = [String]()
    var resultKey = String()
    var resultDict = NSDictionary()
    var tempDict = NSDictionary()
    var tempDict2 = NSDictionary()
    var selectArray = [NSDictionary]()
    var setLocation = CLLocation()
    var tempC = Int()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "resultsSegue" {
            let resultsController = segue.destination as! ResultsViewController
            resultsController.resultDictGenerated = self.resultDict
        } else {
        }
    }
    
    // Mark: Database Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        showAnimate()
        runShadow()
        runSearch()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0, execute: {
            self.runResult()
        })
        
    }
    
    func runShadow() {
        UIView.animate(withDuration: 1.5, delay: 0.0, options:[UIView.AnimationOptions.repeat, UIView.AnimationOptions.autoreverse], animations: {
            self.BlueShadow.alpha = 0
            self.BlueShadow.alpha = 1
        }, completion: nil

    )}
    
    func showAnimate() {
        self.view.transform = CGAffineTransform(scaleX: 1.3,y: 1.3)
        self.view.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
    
    func runSearch() {
        let center = setLocation
        let circleQuery = geoFire.query(at: center, withRadius: Double(UserDefaults.standard.float(forKey: "SearchDistance")))
        let queryHandle = circleQuery.observe(.keyEntered, with: { (key: String!, location: CLLocation!) in
            self.users.append(key)
 //           print(self.users)
        })
        circleQuery.observeReady({ () -> Void in
            self.runResults(keyArray: self.users, completion: { (completeArray) in
                let randomSelection = arc4random_uniform(UInt32(Int(completeArray.count - 1)))
                self.resultDict = completeArray[Int(randomSelection)]
            })
        })
    }
    
    func runResult() {
        performSegue(withIdentifier: "resultsSegue", sender: self)
    }

    func runResults(keyArray: Array<String>, completion: @escaping (Array<NSDictionary>) -> ()) {
        var runResultsCount = 0
        for key in keyArray {
            runResultsCount = runResultsCount + 1
            self.ref.child(key).observeSingleEvent(of: .value, with: { (snapshot) in
                self.tempDict = snapshot.value as! NSDictionary
                if self.filterResults(tdict: self.tempDict) == true {
                    self.selectArray.append(self.tempDict)
                    completion(self.selectArray)
                }
            })
        }
    }
    func filterResults(tdict: NSDictionary) -> Bool {
        self.tempC = 0
        if tdict["Price"] as? String == UserDefaults.standard.string(forKey: "PricePreference") {
            self.tempC = 0
        } else {
            self.tempC = 1
        }
        if self.tempC == 1 {
            return false
        } else {
            return true
        }
        
    }
    
    
    
    
}

// MARK: LOAD GEODATA

//        ref.observeSingleEvent(of: .value, with: { (snapshot) in
//            // Get user value
//            for item in snapshot.children {
//
//                let child = item as! DataSnapshot
//                let key = child.key as String
//                let value = child.value as! NSDictionary
//
//                var latitude = Float()
//                var longitude = Float()
//                if let n = value["Latitude"] as? NSNumber {
//                    latitude = n.floatValue }
//                if let n = value["Longitude"] as? NSNumber {
//                    longitude = n.floatValue }
//                let coordinates = CLLocation(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
//
//                self.geoFire.setLocation(coordinates, forKey: key) { (error) in
//                    if (error != nil) {
//                        print("error")
//                    } else {
//                        self.ref.child(key).child("Location_Generated").setValue(true)
//                        print("complete")
//                    }
//                }
//            }
//            })
