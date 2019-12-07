//
//  LoginVC.swift
//  Ouro
//
//  Created by PC on 21/10/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit
import Firebase
import FacebookCore
import FacebookLogin
import FacebookShare
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit

class LoginVC: BaseViewController {
    
    @IBOutlet weak var lblSignUp: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUptext(lblSignup: lblSignUp, String1: "Don't have an account?", String2: "Sign Up")
        SetUptextField()
        setupnavigation()
    }
    
    func SetUptextField()
    {
        setTextfieldAsSelected(txtEmail, strText: "Email")
        setTextfieldAsSelected(txtPassword, strText: "Password")
    }
    
    func setupnavigation()
    {
        SetGoBack(img: "Back Chevron")
    }
  
    @IBAction func btnLogin(_ sender: Any) {
        loginButtonClicked(email: txtEmail.text!, password: txtPassword.text!)
    }
    
    //MARK:  LogInFunction
    func loginButtonClicked(email:String,password:String){
        self.showSpinner(onView: self.view)
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if let error = error, user == nil {
                print(error.localizedDescription)
            }
            else
            {
                print("Login Successfully")
                UserDefaults.standard.set(user?.user.uid, forKey: "UserID")
                self.ref = Database.database().reference()
                self.ref.child("Users").child((user?.user.uid)!).observe(DataEventType.value, with: { (snapshot) in
                    print("SNAPSHOT: \(snapshot)")
                    if let userDict = snapshot.value as? [String : AnyObject] {
                        let fname = userDict["FirstName"] as? String
                        let lname = userDict["LastName"] as? String
                        let mobileno = userDict["MobileNo"] as? String
                        let Email = userDict["EmailAddress"] as? String
                        let password = userDict["Password"] as? String
                        CurrentUser.sharedInstance.generalDetails = UserDetail(fname: fname, lname: lname, mobileno: mobileno, email: Email, password: password)
                        if let data = try? JSONEncoder().encode(CurrentUser.sharedInstance.generalDetails) {
                            UserDefaults.standard.set(data, forKey: "Userdata")
                            print(data)
                             self.removeSpinner()
                            let ChooseExeperianceNav = ChooseExperianceVC.instantiate(fromAppStoryboard: .Main)
                            let navigationController = UINavigationController(rootViewController: ChooseExeperianceNav)
                            navigationController.navigationBar.isHidden = true
                            self.present(navigationController, animated: true, completion: nil)
                        }
                        
                    }
                })
                
            }
        }
    }

    @IBAction func btnLoginWithFacebook(_ sender: Any) {
        loginwithfacebookButtonClicked()
    }
    
    //MARK:  LogInWithFacebookFunction
    func loginwithfacebookButtonClicked() {
        self.showSpinner(onView: self.view)
        let loginManager = LoginManager()
        loginManager.logOut()
        loginManager.logIn(permissions: ["public_profile", "email"], viewController: self) { (loginResult) in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
                
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in!")
                print(accessToken)
                let params = ["fields" : "email, name"]
                let graphRequest = GraphRequest(graphPath: "me", parameters: params)
                graphRequest.start { (connection, data, error) in
                    print("Data -- ",data)
                    let tokenString = accessToken.tokenString
                    let credential = FacebookAuthProvider.credential(withAccessToken:tokenString)
                    Auth.auth().signIn(with: credential) { (authResult, error) in
                      if let error = error {
                        print("Error",error)
                        return
                      }else{
                        print("authresult -- ",authResult)
                        self.removeSpinner()
                        let ChooseExeperianceNav = ChooseExperianceVC.instantiate(fromAppStoryboard: .Main)
                        let navigationController = UINavigationController(rootViewController: ChooseExeperianceNav)
                        navigationController.navigationBar.isHidden = true
                        self.present(navigationController, animated: true, completion: nil)
                        }
                       
                    }
                }
                
            }
        }
    }
}
