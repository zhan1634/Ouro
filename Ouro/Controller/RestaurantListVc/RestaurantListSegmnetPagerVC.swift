//
//  RestaurantListSegmnetPagerVC.swift
//  Ouro
//
//  Created by MyMAC on 10/08/19.
//  Copyright © 2019 Ouro. All rights reserved.
//


//EDIT: ******************
import UIKit
import MXSegmentedPager
class RestaurantListSegmnetPagerVC: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblAwards: UILabel!
    @IBOutlet weak var lblCheckIn: UILabel!
    @IBOutlet weak var lblAwardNo: UILabel!
    @IBOutlet weak var lblCheckInNO: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var ViewSegment: MXSegmentedPager!
    //MARK:- variable
    var Viewcontrollers = [UIViewController]()
    var historyVc: HistoryListVC!
    var UpcomignVc : UpcomingListVC!
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpUI()
    }
    func SetUpUI()  {
        
        lblAwards.textColor = #colorLiteral(red: 0.4196078431, green: 0.5411764706, blue: 0.937254902, alpha: 1)
        lblAwardNo.textColor = #colorLiteral(red: 0.4196078431, green: 0.5411764706, blue: 0.937254902, alpha: 1)
        lblCheckIn.textColor = #colorLiteral(red: 0.4196078431, green: 0.5411764706, blue: 0.937254902, alpha: 1)
        lblCheckInNO.textColor = #colorLiteral(red: 0.4196078431, green: 0.5411764706, blue: 0.937254902, alpha: 1)
        lblUserName.textColor = #colorLiteral(red: 0.4196078431, green: 0.5411764706, blue: 0.937254902, alpha: 1)

        imgProfile.layer.masksToBounds = true
        imgProfile.layer.cornerRadius = imgProfile.frame.height / 2
        imgProfile.clipsToBounds = true
      
      if let userID = UserDefaults.standard.value(forKey: "FB_ID") as? String{
        if let userName = UserDefaults.standard.value(forKey: "FB_name") as? String{
          lblUserName.text = userName
        }else{
          lblUserName.text = ""
        }
        let url = "https://graph.facebook.com/\(userID)/picture?type=large"
        self.imgProfile!.sd_setImage(with: URL(string: url), placeholderImage: #imageLiteral(resourceName: "Logo_White"), options: .retryFailed, progress: nil, completed: nil)
      }else{
        self.imgProfile.image = #imageLiteral(resourceName: "Facebook")
      }
        self.ViewSegment.segmentedControl.selectionIndicatorLocation =
            HMSegmentedControlSelectionIndicatorLocation.down
        self.ViewSegment.segmentedControl.tintColor =  #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.ViewSegment.segmentedControl.titleTextAttributes = [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), NSAttributedString.Key.font : UIFont.systemFont(ofSize: 22)]
        self.ViewSegment.segmentedControl.selectedTitleTextAttributes = [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), NSAttributedString.Key.font : UIFont.systemFont(ofSize: 22)]
        self.ViewSegment.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyle.fullWidthStripe
        self.ViewSegment.segmentedControl.selectionIndicatorColor = #colorLiteral(red: 0.4196078431, green: 0.5411764706, blue: 0.937254902, alpha: 1)
        self.ViewSegment.segmentedControl.segmentEdgeInset = UIEdgeInsets(top:0, left: 10, bottom: 0, right: 10)
        self.ViewSegment.segmentedControl.selectionIndicatorHeight = 2.0
        self.ViewSegment.bounces = false
        self.ViewSegment.delegate = self
        self.ViewSegment.dataSource = self
        Viewcontrollers.removeAll()
        let sb :UIStoryboard = UIStoryboard(name: "Restaurant", bundle: nil)
        let vc1  = sb.instantiateViewController(withIdentifier: "HistoryListVC") as! HistoryListVC
        vc1.title = "History"
        vc1.superVc = self
        let Vc2 = sb.instantiateViewController(withIdentifier: "UpcomingListVC") as! UpcomingListVC
        Vc2.title = "Upcoming"
        Vc2.superVc = self
        Viewcontrollers.append(vc1)
        Viewcontrollers.append(Vc2)
        self.ViewSegment.reloadData()
    }
  
  //MARK: Back Button Action
  @IBAction func backButtonAction(_ sender: Any) {
    if let _ = self.parent {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }else {
        let resultVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ParametersViewController") as! ParametersViewController
        self.present(resultVC, animated: true, completion: nil)
    }
  }
  
}
//MARK: - MXsegmentPagerDelegate, MXsegmentPagerDataSource
extension RestaurantListSegmnetPagerVC: MXSegmentedPagerDelegate,
MXSegmentedPagerDataSource {
    func numberOfPages(in segmentedPager: MXSegmentedPager) -> Int {
        return Viewcontrollers.count
    }
    func segmentedPager(_ segmentedPager: MXSegmentedPager, titleForSectionAt
        index: Int) -> String {
        return Viewcontrollers[index].title!
    }
    func segmentedPager(_ segmentedPager: MXSegmentedPager, viewForPageAt index:
        Int) -> UIView {
        return Viewcontrollers[index].view
    }
    func segmentedPager(_ segmentedPager: MXSegmentedPager,
                        viewControllerForPageAtIndex index: Int) -> UIViewController {
        return Viewcontrollers[index]
    }
  
  
}

//END EDIT: ******************
