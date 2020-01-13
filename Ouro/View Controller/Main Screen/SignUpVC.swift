//
//  SignUpVC.swift
//  Ouro
//
//  Created by PC on 21/10/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit
import Firebase



class SignUpVC: BaseViewController {
    
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtMobileNo: UITextField!
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var txtPassWord: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var lblSignIn: UILabel!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         SetUptextField()
         SetUptext(lblSignup: lblSignIn, String1: "Already have an Account?", String2: "Sign In")
        SetGoBack(img: "Back Chevron")
    }
    
    func SetUptextField()
    {
        setTextfieldAsSelected(txtName, strText: "Your Name")
        setTextfieldAsSelected(txtLastName, strText: "Last Name")
        setTextfieldAsSelected(txtMobileNo, strText: "Mobile Number")
        setTextfieldAsSelected(txtEmailAddress, strText: "Email Address")
        setTextfieldAsSelected(txtPassWord, strText: "Password")
        setTextfieldAsSelected(txtConfirmPassword, strText: "ConfirmPassword")
    }
    
    @IBAction func btnRegisterUser(_ sender: Any) {
        self.showSpinner(onView: self.view)
       Auth.auth().createUser(withEmail: txtEmailAddress.text!, password: txtPassWord.text!) {
            (user, error) in
            if error != nil {
                 self.removeSpinner()
                print(error?.localizedDescription)
                self.shakeview()
                self.errorlabel()
            } else {
                print("Registration Successful!")
                self.ref = Database.database().reference()
                let dic = ["FirstName":self.txtName.text ?? "",
                           "LastName":self.txtLastName.text ?? "",
                           "MobileNo":self.txtMobileNo.text ?? "",
                           "EmailAddress":self.txtEmailAddress.text ?? "",
                           "Password":self.txtPassWord.text ?? ""] as [String : Any]
                self.ref.child("Users").child((user?.user.uid)!).setValue(dic)
                CurrentUser.sharedInstance.generalDetails = UserDetail(fname: self.txtName.text, lname: self.txtLastName.text, mobileno:self.txtMobileNo.text, email: self.txtEmailAddress.text, password: self.txtPassWord.text)
                if let data = try? JSONEncoder().encode(CurrentUser.sharedInstance.generalDetails) {
                UserDefaults.standard.set(data, forKey: "Userdata")
                print(data)
                    self.removeSpinner()
                    let ChooseExeperianceNav = ChooseExperianceVC.instantiate(fromAppStoryboard: .Main)
                    let navigationController = UINavigationController(rootViewController: ChooseExeperianceNav)
                    navigationController.navigationBar.isHidden = true
                    navigationController.modalPresentationStyle = .fullScreen
                    self.present(navigationController, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    //MARK:  Label for display the error message
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
    
    //MARK:  Remove the error message
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
    
    //MARK:  Shake the screen when error in registration
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
