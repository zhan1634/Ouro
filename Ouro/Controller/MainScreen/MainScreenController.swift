//
//  ViewController.swift
//  Ouro iOSApplication v1
//
//  Created by Jack Zhang on 2019-04-28.
//  Copyright © 2019 Ouro. All rights reserved.
//

import UIKit
import Firebase
//EDIT: ******************(Single tone)
var globalMainScreenVC : MainScreenController?
//END EDIT: ******************
class MainScreenController: UIViewController {

    let backgroundImageView = UIImageView()
    var signinreplay = false
    
    @IBOutlet var SignInButton: UIButton!
    @IBOutlet var RegisterButton: UIButton!
    @IBOutlet var MenuButton: UIImageView!
    @IBOutlet var CheckInButton: UIImageView!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var SubtitleLabel: UILabel!
    @IBOutlet weak var OuroButton: UIButton!
    @IBOutlet var SignOutButton: UIButton!
    @IBOutlet var WelcomeLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
      //EDIT: ******************
        globalMainScreenVC = self
      //END EDIT: ******************
        // SET VIEWS
        self.setBackground()
        self.setLoginRegister()
        self.setCenter()
        self.setButtons()
      
      
      
        
        // AUTHENTICATION LISTENER
        Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
            
                self.RegisterButton.removeFromSuperview()
                self.SignInButton.removeFromSuperview()
                self.setWelcome()
              if let userName = UserDefaults.standard.value(forKey: "FB_name") as? String{
                self.WelcomeLabel.text = "Welcome " + userName
              }else{
                self.WelcomeLabel.text = "Welcome " + String(user.email ?? "")
              }
            }else {
                self.WelcomeLabel.removeFromSuperview()
                self.SignOutButton.removeFromSuperview()
                self.setLoginRegister()
            }
        }
      
      //Button Actions
      tapGestureForCheckInButton()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
  
  
  //EDIT: ******************
  //MARK: Gesture For CheckIn button
  func tapGestureForCheckInButton()  {
    let tap = UITapGestureRecognizer(target: self, action: #selector(tapEventOfCheckInButton))
    CheckInButton.isUserInteractionEnabled = true
    CheckInButton.addGestureRecognizer(tap)
  }
  @objc func tapEventOfCheckInButton(){
    let registrationVC = UIStoryboard(name: "Restaurant", bundle: nil).instantiateViewController(withIdentifier: "RestaurantListSegmnetPagerVC") as! RestaurantListSegmnetPagerVC
    self.addChild(registrationVC)
    registrationVC.view.frame = self.view.frame
    self.view.addSubview(registrationVC.view)
    registrationVC.didMove(toParent: self)
  }
  //END EDIT: ******************
    // MARK: Solo / Group Popover Presentation
    @IBAction func logoGroupSelection(_ sender: Any) {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ouroSelectionGroup") as! popUpGroupSelection
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
        
    }
    
    
    @IBAction func RegisterUser(_ sender: Any) {
        self.registerUser()
    }
    
    func registerUser() {
        let registrationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "registerSelection") as! RegistrationViewController
        registrationVC.delegate = self
        self.addChild(registrationVC)
        registrationVC.view.frame = self.view.frame
        self.view.addSubview(registrationVC.view)
        registrationVC.didMove(toParent: self)
    }
    
    @IBAction func LoginUser(_ sender: Any) {
        let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginSelection") as! LoginViewController
        self.addChild(loginVC)
        loginVC.delegate = self
        loginVC.view.frame = self.view.frame
        self.view.addSubview(loginVC.view)
        loginVC.didMove(toParent: self)
    }
    
    @IBAction func LogOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.removeObject(forKey: "FB_name")
            UserDefaults.standard.removeObject(forKey: "FB_ID")
        } catch {
            print("Error while signing out!")
        }
    }
    
    
    // MARK: Layout Contraints
    func setBackground() {
        
        self.view.addSubview(backgroundImageView)
        backgroundImageView.image = UIImage(named: "BG_Home_Food")
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        backgroundImageView.contentMode = .scaleAspectFill
        view.sendSubviewToBack(backgroundImageView)

    }
    
    func setLoginRegister() {
           
        self.view.addSubview(SignInButton)
        self.view.addSubview(RegisterButton)
        
        SignInButton.translatesAutoresizingMaskIntoConstraints = false
        RegisterButton.translatesAutoresizingMaskIntoConstraints = false
        
        let bottombounds = self.view.frame.height * 0.05
        let sidebounds = self.view.frame.width * 0.10
        let widthbounds = self.view.frame.width * 0.33
        
        SignInButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -1 * bottombounds).isActive = true
        SignInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sidebounds).isActive = true
        SignInButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        SignInButton.widthAnchor.constraint(equalToConstant: widthbounds).isActive = true
        
        RegisterButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -1 * bottombounds).isActive = true
        RegisterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1 * sidebounds).isActive = true
        RegisterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        RegisterButton.widthAnchor.constraint(equalToConstant: widthbounds).isActive = true
        
    }
    
    func setWelcome() {
        
        self.view.addSubview(self.WelcomeLabel)
        self.view.addSubview(self.SignOutButton)
        
        WelcomeLabel.adjustsFontSizeToFitWidth = true
        WelcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        SignOutButton.translatesAutoresizingMaskIntoConstraints = false
        
        let bottombounds = self.view.frame.height * 0.05
        let sidebounds = self.view.frame.width * 0.10
        let heightbounds = self.view.frame.height * 0.04
        
        WelcomeLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: (-1 * bottombounds - 22)).isActive = true
        WelcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sidebounds).isActive = true
        WelcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1 * sidebounds).isActive = true
        WelcomeLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true

        SignOutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -1 * bottombounds).isActive = true
        SignOutButton.heightAnchor.constraint(equalToConstant: heightbounds).isActive = true
        SignOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setCenter() {
        
        self.view.addSubview(TitleLabel)
        self.view.addSubview(SubtitleLabel)
        self.view.addSubview(OuroButton)
        
        TitleLabel.adjustsFontSizeToFitWidth = true
        SubtitleLabel.adjustsFontSizeToFitWidth = true
        TitleLabel.translatesAutoresizingMaskIntoConstraints = false
        SubtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        OuroButton.translatesAutoresizingMaskIntoConstraints = false
        
        let centeroffset = self.view.frame.height * 0.0335
        let heightbounds = min(80, self.view.frame.height * 0.09)
        
        SubtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        SubtitleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -1 * centeroffset).isActive = true
        SubtitleLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        SubtitleLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.8).isActive = true
        
        TitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        TitleLabel.centerYAnchor.constraint(equalTo: SubtitleLabel.centerYAnchor, constant: -40).isActive = true
        TitleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        TitleLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.8).isActive = true
        
        OuroButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        OuroButton.centerYAnchor.constraint(equalTo: SubtitleLabel.centerYAnchor, constant: 70).isActive = true
        OuroButton.heightAnchor.constraint(equalToConstant: heightbounds).isActive = true
        OuroButton.widthAnchor.constraint(equalToConstant: heightbounds).isActive = true
        
    }
    
    func setButtons() {
        
        self.view.addSubview(MenuButton)
        self.view.addSubview(CheckInButton)
        
        MenuButton.translatesAutoresizingMaskIntoConstraints = false
        CheckInButton.translatesAutoresizingMaskIntoConstraints = false
        
        let sidebounds = self.view.frame.width * 0.085
        let topbounds = self.view.frame.height * 0.07
        let size = self.view.frame.width * 0.0966
        
        MenuButton.topAnchor.constraint(equalTo: view.topAnchor, constant: topbounds).isActive = true
        MenuButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sidebounds).isActive = true
        MenuButton.heightAnchor.constraint(equalToConstant: size).isActive = true
        MenuButton.widthAnchor.constraint(equalToConstant: size).isActive = true
        MenuButton.contentMode = .scaleAspectFit
        
        CheckInButton.topAnchor.constraint(equalTo: view.topAnchor, constant: topbounds).isActive = true
        CheckInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1 * sidebounds).isActive = true
        CheckInButton.heightAnchor.constraint(equalToConstant: size).isActive = true
        CheckInButton.widthAnchor.constraint(equalToConstant: size).isActive = true
        CheckInButton.contentMode = .scaleAspectFit
        
    }
}
//EDIT: ******************
extension MainScreenController: UserDataDelegate,UserDataLoginDelegate{
  func getUserData(userData: [String : Any]) {
    if let userName = UserDefaults.standard.value(forKey: "FB_name") as? String{
       self.setWelcome()
      self.WelcomeLabel.text = "Welcome " + userName
    }
  }
  
  func getUserLoginData(userData: [String : Any]) {
    if let userName = UserDefaults.standard.value(forKey: "FB_name") as? String{
      self.setWelcome()
      self.WelcomeLabel.text = "Welcome " + userName
    }
  }
}

//END EDIT: ******************
