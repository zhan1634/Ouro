//
//  MainVC.swift
//  Ouro
//
//  Created by PC on 21/10/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit

class MainVC: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupnavigation()    
    }
    
    func setupnavigation()
    {
        SetNavigationTitle(Navname: "OURO")
        //setLeftMenubtn(img: "Menu Icon")
        setRightMenubtn(img: "Check In")
    }
    
    @IBAction func btnChooseexperiance(_ sender: Any) {
        let ChooseExeperianceNav = ChooseExperianceVC.instantiate(fromAppStoryboard: .Main)
         let navigationController = UINavigationController(rootViewController: ChooseExeperianceNav)
         navigationController.navigationBar.isHidden = true
        navigationController.modalPresentationStyle = .fullScreen
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
