//
//  GenerateExperianceVC.swift
//  Ouro
//
//  Created by PC on 05/11/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit
import Firebase
//import GoogleMaps

//import GeoFire

class GenerateExperianceVC: UIViewController {
    
    var ref = Database.database().reference().child("Restaurants")
    var geoFire = GeoFire(firebaseRef: Database.database().reference().child("Locations"))

    var users = [String]()
    var resultKey = String()
    var resultDict = [String:Any]()
    var tempDict = [String:Any]()
    var tempDict2 = [String:Any]()
    var selectArray = [[String:Any]]()
    var setLocation = CLLocation()
    var tempC = Int()
    var isFromView : Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        runSearch()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
            self.runResult()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isFromView {
            print("generate experiance view will appear")
            let generateexpNav = GoogleMapVC.instantiate(fromAppStoryboard: .Main)
            self.addChild(generateexpNav)
            generateexpNav.view.frame = self.view.frame
            self.view.addSubview(generateexpNav.view)
            generateexpNav.didMove(toParent: self)
            
        }
    }
    
    func runSearch() {
        let center = setLocation
        var radius = UserDefaults.standard.double(forKey: "SearchDistance")
        if radius <= 0 {
            radius = 5
        }//38 Dan Leckie Way Toronto
        let circleQuery = geoFire.query(at: center, withRadius: radius)
        let queryHandle = circleQuery.observe(.keyEntered, with: { (key: String!, location: CLLocation!) in
            self.users.append(key)
            print("Users :",self.users)
        })
        print(self.users.count)
        circleQuery.observeReady({ () -> Void in
            self.runResults(keyArray: self.users, completion: { (completeArray) in
                let randomSelection = completeArray.randomElement()//arc4random_uniform(UInt32(Int(completeArray.count - 1)))
                self.resultDict = randomSelection! as! [String : Any]//completeArray[Int(randomSelection)]
                //self.runResult()
            })
        })
//        if users.count == 0 {
//            let alert = UIAlertController(title: "", message: "No Results Found - Please update your selection and try again", preferredStyle: UIAlertController.Style.alert)
//            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//        }
    }
    
    
    func runResult() {
        removeFromParent()
        isFromView = true
        let Generateexpdetailnav = ViewPreferencesDetailVC.instantiate(fromAppStoryboard: .Main)
        Generateexpdetailnav.resultDictGenerated = self.resultDict
        if #available(iOS 13.0, *) {
            Generateexpdetailnav.isModalInPresentation = true
            Generateexpdetailnav.modalPresentationStyle = .overFullScreen
        } else {
            // Fallback on earlier versions
        }
        
        Generateexpdetailnav.modalPresentationStyle = .overFullScreen
        let navigationController = UINavigationController(rootViewController: Generateexpdetailnav)
        navigationController.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }
    
    func runResults(keyArray: Array<String>, completion: @escaping (Array<NSDictionary>) -> ()) {
        var runResultsCount = 0
        for key in keyArray {
            runResultsCount = runResultsCount + 1
            self.ref.child(key).observeSingleEvent(of: .value, with: { (snapshot) in
                self.tempDict = (snapshot.value as! NSDictionary) as! [String : Any]
                if self.filterResults(tdict: (self.tempDict) as! [String : Any]) == true {
                    self.selectArray.append(self.tempDict)
                    completion(self.selectArray as Array<NSDictionary>)
                }
            })
        }
    }
    
    //EDIT: **********
    func filterResults(tdict: [String:Any]) -> Bool {
        self.tempC = 0
        
        if let pricePreference: String = UserDefaults.standard.value(forKey: "PricePreference") as? String{
            if tdict["Price"] as? String == pricePreference {
                self.tempC = 0
            } else {
                self.tempC = 1
            }
        }else{
            if tdict["Price"] as? String == "$" {
                self.tempC = 0
            } else {
                self.tempC = 1
            }
        }
        
        if self.tempC == 1 {
            return false
        } else {
            return true
        }
        
    }
    
}


