//
//  LoginViewController.swift
//  Ouro
//
//  Created by Jack Zhang on 2019-05-02.
//  Copyright © 2019 Ouro. All rights reserved.
//

import UIKit
import Firebase
import FacebookCore
import FacebookLogin
import FacebookShare
import FBSDKLoginKit
import FBSDKShareKit

protocol UserDataLoginDelegate {
  func getUserLoginData(userData:[String:Any])
}

class LoginViewController: UIViewController {

    @IBOutlet weak var LoginTitle: UILabel!
    @IBOutlet weak var GoBack: UIButton!
    
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var EmailLogin: UITextField!
    @IBOutlet weak var PasswordLabel: UILabel!
    @IBOutlet weak var PasswordLogin: UITextField!
    @IBOutlet weak var NLoginButton: UIButton!
  //EDIT: ******************
  @IBOutlet weak var FacebookLoginButton: UIButton!
   var delegate : UserDataLoginDelegate?
  //END EDIT ******************
  @IBOutlet weak var DontHaveAccountLabel: UILabel!
    @IBOutlet weak var SignUpButton: UIButton!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Formats
        self.setexlabels()
        self.setlabelswtextinputs()
        self.showAnimate()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func LoginUser(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: EmailLogin.text!, password: PasswordLogin.text!) {
            (user, error) in
            if error != nil {
                self.shakeview()
                self.errorlabel()
            } else {
                print("Login Successful!")
                self.willMove(toParent: nil)
                self.view.removeFromSuperview()
                self.removeFromParent()
            }
        }
    }
    
    @IBAction func GoBackPressed(_ sender: Any) {
        self.removeAnimate()
    }
    
    @IBAction func SignUpPressed(_ sender: Any) {
        
        let registrationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "registerSelection") as! RegistrationViewController
        registrationVC.delegate = self
        self.parent!.addChild(registrationVC)
        registrationVC.view.frame = self.parent!.view.frame
        self.parent!.view.addSubview(registrationVC.view)
        registrationVC.didMove(toParent: self.parent)
        
        removeAnimate()
        
    }

 //EDIT: ******************
  @IBAction func LoginWithFacebookPressed(_ sender: Any) {
    loginButtonClicked()
  }
  
  //EDIT: ******************
  @objc func loginButtonClicked() {
    
    let loginManager = LoginManager()
    loginManager.logOut()
    loginManager.logIn(permissions: [.publicProfile], viewController: self) { (loginResult) in
      switch loginResult {
      case .failed(let error):
        print(error)
      case .cancelled:
        print("User cancelled login.")
        
      case .success(let grantedPermissions, let declinedPermissions, let accessToken):
        print("Logged in!")
        
        let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
        Auth.auth().signInAndRetrieveData(with: credential, completion: { (authResult, error) in
          if let error = error {
            print(error)
            return
          }
          let request =  GraphRequest(graphPath: "me")
          request.start(completionHandler: { (connection, result, error) in
            if error != nil {
              print(error as Any)
            }else {
              print(result as Any)
              if let userdata = result as? [String:Any] {
                if let FB_id = userdata["id"] as? String,let FB_name = userdata["name"] as? String{
                  UserDefaults.standard.set(FB_id, forKey: "FB_ID")
                  UserDefaults.standard.set(FB_name, forKey: "FB_name")
                  self.delegate?.getUserLoginData(userData: userdata)
                }
              }
            }
          })
          print(authResult as Any)
          
          self.willMove(toParent: nil)
          self.view.removeFromSuperview()
          self.removeFromParent()
          // User is signed in
          // ...
        })
      }
    }
  }
  //END EDIT: ******************
    func setlabelswtextinputs() {
        
        let LabelArray = [EmailLabel, PasswordLabel]
        let RegisterArray = [EmailLogin, PasswordLogin]
        
        let sidebounds = self.view.frame.width * 0.24154
        var loopNumber = 0
        let startingPosition = (self.view.frame.height - 200) / 2
        
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
        
        self.view.addSubview(LoginTitle)
        self.view.addSubview(NLoginButton)
        self.view.addSubview(DontHaveAccountLabel)
        self.view.addSubview(SignUpButton)
        self.view.addSubview(GoBack)
        
        LoginTitle.translatesAutoresizingMaskIntoConstraints = false
        NLoginButton.translatesAutoresizingMaskIntoConstraints = false
      //EDIT: ******************
        FacebookLoginButton.translatesAutoresizingMaskIntoConstraints = false
      //END EDIT: ******************
        DontHaveAccountLabel.translatesAutoresizingMaskIntoConstraints = false
        SignUpButton.translatesAutoresizingMaskIntoConstraints = false
        GoBack.translatesAutoresizingMaskIntoConstraints = false
        
        let startingPosition = (self.view.frame.height - 200) / 2 - 55.0
        
        LoginTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: startingPosition).isActive = true
        LoginTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        LoginTitle.heightAnchor.constraint(equalToConstant: 40).isActive = true

   //EDIT: ******************
        NLoginButton.topAnchor.constraint(equalTo: view.topAnchor, constant: startingPosition + 200.0).isActive = true
        NLoginButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        NLoginButton.widthAnchor.constraint(equalToConstant: PasswordLogin.frame.width).isActive = true
        NLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
      
        FacebookLoginButton.topAnchor.constraint(equalTo: view.topAnchor, constant: startingPosition + 260.0).isActive = true
        FacebookLoginButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        FacebookLoginButton.widthAnchor.constraint(equalToConstant: PasswordLogin.frame.width).isActive = true
        FacebookLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
   //END EDIT : ******************
        DontHaveAccountLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: startingPosition + 320).isActive = true
        DontHaveAccountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -25.0).isActive = true
        DontHaveAccountLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        DontHaveAccountLabel.widthAnchor.constraint(equalToConstant: 160).isActive = true
        DontHaveAccountLabel.adjustsFontSizeToFitWidth = true
        
        SignUpButton.topAnchor.constraint(equalTo: view.topAnchor, constant: startingPosition + 320).isActive = true
        SignUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 60.0).isActive = true
        SignUpButton.heightAnchor.constraint(equalToConstant: 18).isActive = true
        SignUpButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
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
    
    func errorlabel() {
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width * 0.8, height: 15))
        label.textAlignment = .center
        label.text = "Email/Password Incorrect"
        label.tag = 99
        label.textColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        self.view.addSubview(label)
        
        let sidebounds = 20.0
        let topshift = (self.view.frame.height - 200) / 2 - 55.0 + 305
        
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
}
//EDIT: ******************
extension LoginViewController: UserDataDelegate{
  func getUserData(userData: [String : Any]) {
    globalMainScreenVC?.getUserData(userData: userData)
  }
}

//END EDIT:****************
