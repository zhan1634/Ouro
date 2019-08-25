//
//  UpcomingListVC.swift
//  Ouro
//
//  Created by MyMAC on 10/08/19.
//  Copyright © 2019 Ouro. All rights reserved.
//


//EDIT: ******************
import UIKit
import MXSegmentedPager
import Firebase
class UpcomingListVC: UIViewController {

  var superVc: RestaurantListSegmnetPagerVC!
  var ref = Database.database().reference()
  var pendingdict = [[Int: NSDictionary]](){
            didSet{
                    DispatchQueue.main.async {
                        self.tbl.reloadData()
                      }
                  }
          }
  @IBOutlet weak var tbl: UITableView!
  
  
  override func viewDidLoad() {
    Auth.auth().addStateDidChangeListener { auth, user in
      if let user = user {
      
        self.ref.child("Pending").child(user.uid).observeSingleEvent(of: .value, with: { (snapshot) in
          print("Snapshot: \(snapshot.hasChildren())")
          for item in snapshot.children {
            let child = item as! DataSnapshot
            let timestamp = child.key as String
            let value = child.value as! NSDictionary
            let timestamp_int = Int(timestamp)
            let pending = [timestamp_int: value]
            self.pendingdict.append(pending as! [Int : NSDictionary])
            
          }})
      } else {
        print("No Logged In User")
      }
    }
    super.viewDidLoad()
    tbl.delegate = self
    tbl.dataSource = self
    
    
  }
  
    func getDataInString(timeStamp: Int) -> String {
      var dateString = ""
      let date = Date(timeIntervalSince1970: TimeInterval(timeStamp))
      let dateFormatter = DateFormatter()
      dateFormatter.timeZone = TimeZone(abbreviation: "GMT") 
      dateFormatter.locale = NSLocale.current
      dateFormatter.dateFormat = "dd MMM yyyy"
      dateString = dateFormatter.string(from: date)
      return dateString
    }
  }


extension UpcomingListVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pendingdict.count
    }
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "UpcomingTableViewCell", for: indexPath) as! UpcomingTableViewCell
      let details = pendingdict[indexPath.row]
      for (key,value) in details{
        cell.timeLabel.text = "\(getDataInString(timeStamp: key))"
        cell.addressLabel.text = value["Address"] as? String
        cell.nameLabel.text = value["Name"] as? String
      }
    return cell
    }
  func tableView(_ tableView: UITableView,heightForRowAt indexPath:IndexPath) -> CGFloat{
    return UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
    return 120
  }
    
}
//END EDIT: ******************
