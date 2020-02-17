//
//  RestaurantFoodOrderVC.swift
//  Ouro
//
//  Created by PC on 22/10/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage


class RestaurantFoodOrderVC: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    //MARK:- Outlets
    @IBOutlet weak var tblRestaurantOrder: UITableView!
    
    //MARK:- Variables
    var ref = Database.database().reference()
    var arrpending = [Generatemodel]()
    var pendingDict : Generatemodel?
    var segment:Int = 1
    var firstName : String = String()
    var lastName : String = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUptableView()
        Savedatabasedata()
        self.navigationController?.navigationBar.isHidden = true
        self.tblRestaurantOrder.reloadData()
        let cell = tblRestaurantOrder.cellForRow(at: IndexPath(row: 0, section: 0)) as? RestaurantheaderCell
    }
    func Savedatabasedata()
    {
        Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
            
                print("UserID : \(user.uid)")
                self.ref.child("Pending").child(user.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                    print("Snapshot ResturantFoodOrderVC: \(snapshot.hasChildren())")
                    print(snapshot)
                    for item in snapshot.children {
                        let child = item as! DataSnapshot
                        let timestamp = child.key as String
                        let value = child.value
                        let timestamp_int = Int(timestamp)
                        let pending = value as? [String:Any]
                        print(pending)
                        self.pendingDict = Generatemodel(pending!)
                        self.arrpending.append(self.pendingDict!)
                    }
                    print(self.arrpending)
                    self.tblRestaurantOrder.reloadData()
                    
                })
                
            }
                
            else {
                print("No Logged In User")
            }
            
        }
    }
    func SetUptableView()
    {
        tblRestaurantOrder.delegate = self
        tblRestaurantOrder.dataSource = self
        self.tblRestaurantOrder.register(UINib(nibName: "RestaurantheaderCell", bundle: nil), forCellReuseIdentifier: "RestaurantheaderCell")
        self.tblRestaurantOrder.register(UINib(nibName: "RestaurantCell", bundle: nil), forCellReuseIdentifier: "RestaurantCell")
        self.tblRestaurantOrder.register(UINib(nibName: "RestaurantUpcomingCell", bundle: nil), forCellReuseIdentifier: "RestaurantUpcomingCell")
    }
    
    @objc func handleSegmentControlClick(_ sender:UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            segment = 0
        case 1:
            segment = 1
        default:
            segment = 0
        }
        tblRestaurantOrder.reloadData()
    }
    
    //MARK: tableview Delegate & Datasource Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            return 1
        }
        else
        {
            return arrpending.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantheaderCell") as! RestaurantheaderCell
           // let segmentControl = cell.viewWithTag(1) as! UISegmentedControl
            if let userDict = AppUtility.GetLoginUserData() {
                if let fname = userDict.fname.isEmpty ? "Guest": userDict.fname , let lname = userDict.lname.isEmpty ? "" : userDict.lname {
                        cell.lblUserName.text = fname + " " + lname
                }
            }
            else {
                cell.lblUserName.text = "Guest"
            }
            cell.lblCheckIn.text = "\(arrpending.count == 0 ? 0 : arrpending.count)" + " Ouro Searches"
            cell.segmentedControl.selectedSegmentIndex = segment
            cell.segmentedControl.addTarget(self, action: #selector(self.handleSegmentControlClick(_:)), for: .valueChanged)
            cell.btnBack.addTarget(self, action: #selector(btnBackAction), for: .touchUpInside)
            return cell
        }
       else
        {
            switch segment {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantUpcomingCell", for: indexPath) as! RestaurantUpcomingCell
                cell.btnRestaurantName.setTitle(arrpending[indexPath.row].Name, for: .normal)
                cell.imgRestaurant.sd_setImage(with: URL(string: arrpending[indexPath.row].Photo!), placeholderImage: #imageLiteral(resourceName: "Rectangle 2 Copy 2"), options: .retryFailed, completed: nil)
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as! RestaurantCell
                cell.imgRestaurant.sd_setImage(with: URL(string: arrpending[indexPath.row].Photo!), placeholderImage: #imageLiteral(resourceName: "Rectangle 2 Copy 2"), options: .retryFailed, completed: nil)
                cell.lblRestaurantName.text = arrpending[indexPath.row].Name
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantUpcomingCell", for: indexPath) as! RestaurantUpcomingCell
                return cell
            }
            
        }
       
    }
    @objc func btnBackAction()
       {
//           self.dismiss(animated: true, completion: nil)
//        isFromRestaurantFoodOrderVC = true
           self.navigationController?.popViewController(animated: true)
       }
       
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height:CGFloat = 0.0
        
        if indexPath.section == 0
        {
            height = 200.0//230.0
        }
        else
        {
            height = 200.0
        }
        return height
    }
}
