//
//  BaseViewController.swift
//  Ouro
//
//  Created by PC on 21/10/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var vSpinner : UIView?
    var isFromRestaurantFoodOrderVC : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Set navigation left menu item
    func setLeftMenubtn(img:String) {
          var leftBarBackItem = UIBarButtonItem()
          leftBarBackItem = UIBarButtonItem(image:#imageLiteral(resourceName: img), style: UIBarButtonItem.Style.plain, target: self, action: nil)
          leftBarBackItem.tintColor = UIColor.white
          self.navigationItem.leftBarButtonItem = leftBarBackItem
    }
    
     //MARK: Set navigation left close button
    func setLeftClose(img:String) {
        var leftBarBackItem = UIBarButtonItem()
        leftBarBackItem = UIBarButtonItem(image:#imageLiteral(resourceName: img), style: UIBarButtonItem.Style.plain, target: self, action: #selector(btncloseClicked))
        leftBarBackItem.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = leftBarBackItem
    }
    
    
    @objc func btncloseClicked()
    {
        self.dismiss(animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) { // Change `2.0` to the desired number of seconds.
            self.removeFromParent() // Code you want to be delayed
        }
        
//        let navigationController = self.presentingViewController as? UINavigationController
//
//           self.dismiss(animated: true) {
//             let _ = navigationController?.popToRootViewController(animated: true)
//           }
    }
       func setRemoveChild(img:String) {
            var leftBarBackItem = UIBarButtonItem()
            leftBarBackItem = UIBarButtonItem(image:#imageLiteral(resourceName: img), style: UIBarButtonItem.Style.plain, target: self, action: #selector(btnRemoveChild))
            leftBarBackItem.tintColor = UIColor.white
            self.navigationItem.leftBarButtonItem = leftBarBackItem
        }
        
        
        @objc func btnRemoveChild()
        {
            removeFromParent()
//            self.dismiss(animated: true, completion: nil)
    //        let navigationController = self.presentingViewController as? UINavigationController
    //
    //           self.dismiss(animated: true) {
    //             let _ = navigationController?.popToRootViewController(animated: true)
    //           }
        }
    
    @objc func btnBackClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Set the navigation left item back button
    func SetGoBack(img:String)
    {
        var leftBarBackItem = UIBarButtonItem()
        leftBarBackItem = UIBarButtonItem(image:#imageLiteral(resourceName: img), style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.btnBackClicked))
        leftBarBackItem.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = leftBarBackItem
    }
    
    //MARK: Set the navigation right menu item
    func  setRightMenubtn(img:String){
        var RightBarBackItem = UIBarButtonItem()
        RightBarBackItem = UIBarButtonItem(image:#imageLiteral(resourceName: img), style: UIBarButtonItem.Style.plain, target: self,  action: #selector(setRightMenuClick))
        RightBarBackItem.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = RightBarBackItem
    }
    override func viewWillAppear(_ animated: Bool) {
        print("base view view will appear")
        if isFromRestaurantFoodOrderVC {
            self.navigationController?.navigationBar.isHidden = false
            SetNavigationTitle(Navname: "OURO")
//            setLeftMenubtn(img: "Menu Icon")
            setLeftClose(img: "Back Chevron")
            setRightMenubtn(img: "Check In")
        }
    }
    @objc func setRightMenuClick()  {
        isFromRestaurantFoodOrderVC = true
        let Generatednav = self.storyboard?.instantiateViewController(identifier: "RestaurantFoodOrderVC") as! RestaurantFoodOrderVC
        self.navigationController?.pushViewController(Generatednav, animated: true)
    }
    
    
    //MARK:  Set navigationbar shadow
    func SetupNavigatiionshadow()
    {
        self.navigationController?.navigationBar.layer.shadowColor = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1)
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
        self.navigationController?.navigationBar.layer.shadowRadius = 1.0
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.5
        self.navigationController?.navigationBar.layer.masksToBounds = false
    }
    
    //MARK:  Set navigationbar title
    func SetNavigationTitle(Navname:String)
    {
        let gradient = CAGradientLayer()
        let sizeLength = UIScreen.main.bounds.size.height * 2
        let defaultNavigationBarFrame = CGRect(x: 0, y: 0, width: sizeLength, height: ((self.navigationController?.navigationBar.frame.height)! * 2))
        gradient.frame = defaultNavigationBarFrame
        gradient.colors = [#colorLiteral(red: 0.2352941176, green: 0.7529411765, blue: 0.862745098, alpha: 1).cgColor, #colorLiteral(red: 0.146135211, green: 0.8285922408, blue: 0.502350986, alpha: 1).cgColor]
        let lbltext = UILabel(frame: CGRect(x: (self.navigationController?.navigationBar.frame.width)!/2, y: 0, width: 50, height: (self.navigationController?.navigationBar.frame.height)!))
        lbltext.text = Navname
        lbltext.textColor = UIColor.white
        lbltext.font = UIFont.boldSystemFont(ofSize: 20.0)
        self.navigationItem.titleView = lbltext
    }
    
    //MARK:  Set the two label with two different title amd attribute for signup and login
    func SetUptext(lblSignup : UILabel,String1:String,String2:String)
      {
          let Attributes1: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 15.0)]
        let Attributes2: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 15.0)]
           let partOne = NSMutableAttributedString(string: String1, attributes: Attributes1)
          let partTwo = NSMutableAttributedString(string: String2, attributes: Attributes2)
          partOne.append(partTwo)
          lblSignup.attributedText = partOne
      }
    
    //MARK:  Set the placeholder in textfields
    func setTextfieldAsSelected(_ textField:UITextField, strText:String){
        textField.attributedPlaceholder = NSAttributedString(string: strText, attributes: [
            .foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
            .font: UIFont.boldSystemFont(ofSize: 15.0)
        ])
    }
    
    
    //MARK:  Set the loder
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .large)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            spinnerView.isUserInteractionEnabled = false
            onView.addSubview(spinnerView)
        }
        self.vSpinner = spinnerView
    }
    
    //MARK:  Remove the loader
    func removeSpinner() {
        DispatchQueue.main.async {
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
        }
    }
    
}
