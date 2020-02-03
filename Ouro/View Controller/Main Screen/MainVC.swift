//
//  MainVC.swift
//  Ouro
//
//  Created by PC on 21/10/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit

class MainVC: BaseViewController {
    
    @IBOutlet weak var btnLogIn: ButtonView!
    @IBOutlet weak var btnSignUp: ButtonView!
    @IBOutlet weak var lblWelcome: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fname1 = UserDefaults.standard.string(forKey: "FirstName")
        print(fname1 as Any)
        lblWelcome.text = "Welcome \(fname1 ?? "")"
        if UserDefaults.standard.data(forKey: "Userdata") != nil {
            btnLogIn.isHidden = true
            btnSignUp.isHidden = true
            lblWelcome.isHidden = false
        } else {
            btnLogIn.isHidden = false
            btnSignUp.isHidden = false
            lblWelcome.isHidden = true
        }
//        changeController()
        setupnavigation()
    }
    
    func changeController() {
        if UserDefaults.standard.data(forKey: "Userdata") != nil {
            let ChooseExeperianceNav = ChooseExperianceVC.instantiate(fromAppStoryboard: .Main)
            let navigationController = UINavigationController(rootViewController: ChooseExeperianceNav)
            navigationController.navigationBar.isHidden = true
            navigationController.modalPresentationStyle = .fullScreen
    //        self.navigationController?.pushViewController(navigationController, animated: true)
            self.present(navigationController, animated: true, completion: nil)
        }
    }
    
    func setupnavigation()
    {
//        SetNavigationTitle(Navname: "OURO")
//        self.navigationController?.navigationBar.isHidden = false
//        SetNavigationTitle(Navname: "OURO")
        //setLeftMenubtn(img: "Menu Icon")
//        setRightMenubtn(img: "Check In")
        self.navigationController?.navigationBar.barTintColor = UIColor.init(named: "Background Color")
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationItem.title = "OURO"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    @IBAction func btnChooseexperiance(_ sender: Any) {
        let ChooseExeperianceNav = ChooseExperianceVC.instantiate(fromAppStoryboard: .Main)
        let navigationController = UINavigationController(rootViewController: ChooseExeperianceNav)
        navigationController.navigationBar.isHidden = true
        navigationController.modalPresentationStyle = .fullScreen
//        self.navigationController?.pushViewController(navigationController, animated: true)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    @IBAction func btnLoginVC(_ sender: Any) {
        let LoginNav = LoginVC.instantiate(fromAppStoryboard: .Main)
        navigationController?.pushViewController(LoginNav, animated: true)
    }
    
    @IBAction func btnSignUp(_ sender: Any) {
        let Signupnav = SignUpVC.instantiate(fromAppStoryboard: .Main)
        navigationController?.pushViewController(Signupnav, animated: true)
    }
}
