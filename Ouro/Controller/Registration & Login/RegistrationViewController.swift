//
//  RegistrationViewController.swift
//  Ouro
//
//  Created by Jack Zhang on 2019-05-02.
//  Copyright © 2019 Ouro. All rights reserved.
//

import UIKit
import Firebase

//EDIT: ******************
//import FacebookCore
//import FacebookLogin
//import FacebookShare
//import FBSDKLoginKit
//import FBSDKShareKit

//END EDIT: ******************

protocol UserDataDelegate {
  func getUserData(userData:[String:Any])
}
class RegistrationViewController: UIViewController {

    @IBOutlet weak var RegisterLabel: UILabel!
    @IBOutlet weak var GoBack: UIButton!
    
    @IBOutlet weak var FirstNameLabel: UILabel!
    @IBOutlet weak var LastNameLabel: UILabel!
    @IBOutlet weak var MobileNumberLabel: UILabel!
    @IBOutlet weak var EmailAddressLabel: UILabel!
    @IBOutlet weak var PasswordLabel: UILabel!
    @IBOutlet weak var ConfirmPasswordLabel: UILabel!

    @IBOutlet weak var AlreadyHaveAccountLabel: UILabel!
    @IBOutlet weak var SignInButton: UIButton!
    

    @IBOutlet weak var FirstNameRegister: UITextField!
    @IBOutlet weak var LastNameRegister: UITextField!
    @IBOutlet weak var PhoneNumberRegister: UITextField!
    @IBOutlet weak var EmailRegister: UITextField!
    @IBOutlet weak var PasswordRegister: UITextField!
    @IBOutlet weak var ConfirmPasswordRegister: UITextField!

    @IBOutlet weak var NRegisterButton: UIButton!
  
  
   var delegate : UserDataDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Views
        self.setlabelswtextinputs()
        self.setexlabels()
        self.showAnimate()

        // Do any additional setup after loading the view.
    }
  
  //EDIT: ******************
 //Log In with Facebook code removed
  
  //END EDIT ******************
    @IBAction func RegisterUser(_ sender: Any) {
        
        Auth.auth().createUser(withEmail: EmailRegister.text!, password: PasswordRegister.text!) {
            (user, error) in
            if error != nil {
                self.shakeview()
                self.errorlabel()
            } else {
                print("Registration Successful!")
                self.willMove(toParent: nil)
                self.view.removeFromSuperview()
                self.removeFromParent()
            }
        }
    }
    
    @IBAction func GoBackPressed(_ sender: Any) {
        self.removeAnimate()
    }
    @IBAction func SignInPressed(_ sender: Any) {
        
        let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginSelection") as! LoginViewController
        self.parent!.addChild(loginVC)
        loginVC.view.frame = self.parent!.view.frame
        self.parent!.view.addSubview(loginVC.view)
        loginVC.didMove(toParent: self.parent)
        
        removeAnimate()
        
    }
    
    
    
    // MARK: Formatting and Layout
    
    func setlabelswtextinputs() {
        
        let LabelArray = [FirstNameLabel, LastNameLabel, MobileNumberLabel, EmailAddressLabel, PasswordLabel, ConfirmPasswordLabel]
        let RegisterArray = [FirstNameRegister, LastNameRegister, PhoneNumberRegister, EmailRegister, PasswordRegister, ConfirmPasswordRegister]
        
        let sidebounds = self.view.frame.width * 0.24154
        var loopNumber = 0
        //let startingPosition = (self.view.frame.height / 2) - self.view.frame.height * 0.24
        let startingPosition = (self.view.frame.height - 400) / 2
        
        for input in LabelArray {
            
            let movementposition = startingPosition + CGFloat(loopNumber * 60)
            
            if let label = input {
                self.view.addSubview(label)
                label.translatesAutoresizingMaskIntoConstraints = false
                label.topAnchor.constraint(equalTo: view.topAnchor, constant: movementposition).isActive = true
                label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sidebounds).isActive = true
                label.heightAnchor.constraint(equalToConstant: 30).isActive = true
                
            }

            if let textfield = RegisterArray[loopNumber] {
                self.view.addSubview(textfield)
                textfield.translatesAutoresizingMaskIntoConstraints = false
                textfield.topAnchor.constraint(equalTo: view.topAnchor, constant: movementposition + 24.0).isActive = true
                textfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sidebounds).isActive = true
                textfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1 * sidebounds).isActive = true
                textfield.heightAnchor.constraint(equalToConstant: 30).isActive = true
                
            }
            
            loopNumber = loopNumber + 1
        }
        
    }
    
    func setexlabels() {
        
        self.view.addSubview(RegisterLabel)
        self.view.addSubview(AlreadyHaveAccountLabel)
        self.view.addSubview(SignInButton)
        self.view.addSubview(NRegisterButton)
      //  self.view.addSubview(btnFaceBook)
        self.view.addSubview(GoBack)

        RegisterLabel.translatesAutoresizingMaskIntoConstraints = false
        AlreadyHaveAccountLabel.translatesAutoresizingMaskIntoConstraints = false
        SignInButton.translatesAutoresizingMaskIntoConstraints = false
        NRegisterButton.translatesAutoresizingMaskIntoConstraints = false
       // btnFaceBook.translatesAutoresizingMaskIntoConstraints = false
        GoBack.translatesAutoresizingMaskIntoConstraints = false
        
        let startingPosition = (self.view.frame.height - 400) / 2 - 55.0

        RegisterLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: startingPosition).isActive = true
        RegisterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        RegisterLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        NRegisterButton.topAnchor.constraint(equalTo: view.topAnchor, constant: startingPosition + 455).isActive = true
        NRegisterButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        NRegisterButton.widthAnchor.constraint(equalToConstant: 115).isActive = true
        NRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
       
//        btnFaceBook.topAnchor.constraint(equalTo:  view.topAnchor, constant: startingPosition + 500.0).isActive = true
//        btnFaceBook.heightAnchor.constraint(equalToConstant: 35).isActive = true
//        btnFaceBook.widthAnchor.constraint(equalToConstant: 35).isActive = true
//        btnFaceBook.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        AlreadyHaveAccountLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: startingPosition + 500.0).isActive = true
        AlreadyHaveAccountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -25.0).isActive = true
        AlreadyHaveAccountLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        AlreadyHaveAccountLabel.widthAnchor.constraint(equalToConstant: 160).isActive = true
        AlreadyHaveAccountLabel.adjustsFontSizeToFitWidth = true
        
        SignInButton.topAnchor.constraint(equalTo: view.topAnchor, constant: startingPosition + 500.0).isActive = true
        SignInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 70.0).isActive = true
        SignInButton.heightAnchor.constraint(equalToConstant: 18).isActive = true
        SignInButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        let sidebounds = self.view.frame.width * 0.085
        let topbounds = self.view.frame.height * 0.02
        
        GoBack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topbounds).isActive = true
        GoBack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: sidebounds).isActive = true
        GoBack.heightAnchor.constraint(equalToConstant: 20).isActive = true
        GoBack.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
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
    
    func errorlabel() {
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width * 0.8, height: 15))
        label.textAlignment = .center
        label.text = "Email/Password Incorrect"
        label.tag = 99
        label.textColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        self.view.addSubview(label)
        
        let sidebounds = 20.0
        let topshift = (self.view.frame.height - 400) / 2 - 55.0 + 560
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(sidebounds)).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: CGFloat(-1 * sidebounds)).isActive = true
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: topshift).isActive = true
        label.heightAnchor.constraint(equalToConstant: 15.0).isActive = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            self.removelabel()
        })
    }
    
    func removelabel() {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.viewWithTag(99)!.alpha = 0.0
        }, completion: { (finished: Bool) in
            if (finished) {
                if let viewWithTag = self.view.viewWithTag(99) {
                    viewWithTag.removeFromSuperview()
                }
            }
        })
    }
    
    func shakeview() {
        
        let lockView = self.view
        
        let midX = lockView!.center.x
        let midY = lockView!.center.y
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.09
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = CGPoint(x: midX - 3, y: midY)
        animation.toValue = CGPoint(x: midX + 3, y: midY)
        self.view.layer.add(animation, forKey: "position")
        
    }
}
