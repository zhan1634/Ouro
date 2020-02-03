//
//  ChooseExperianceVC.swift
//  Ouro
//
//  Created by PC on 21/10/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit

class ChooseExperianceVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnSolo(_ sender: Any) {
      let SoloNav = GoogleMapVC.instantiate(fromAppStoryboard: .Main)
      let navigationController = UINavigationController(rootViewController: SoloNav)
      navigationController.navigationBar.isHidden = true
      navigationController.modalPresentationStyle = .fullScreen
      self.present(navigationController, animated: true, completion: nil)
    }
    
    @IBAction func btnGroup(_ sender: Any) {
        
    }
    
    @IBAction func btnClose(_ sender: Any) {
//        dismiss(animated: true, completion: {
//            let ChooseExeperianceNav = MainVC.instantiate(fromAppStoryboard: .Main)
//            let navigationController = UINavigationController(rootViewController: ChooseExeperianceNav)
//            navigationController.navigationBar.isHidden = true
//            navigationController.modalPresentationStyle = .fullScreen
////                            self.navigationController?.pushViewController(navigationController, animated: true)
//            self.present(navigationController, animated: true, completion: nil)
//        UserDefaults.standard.synchronize()
//        UserDefaults.standard.removeObject(forKey: "Userdata")
        let mainVC = MainVC.instantiate(fromAppStoryboard: .Main)
        let navigationController = UINavigationController(rootViewController: mainVC)
//        navigationController.navigationBar.isHidden = false
        navigationController.modalPresentationStyle = .overFullScreen
        self.present(navigationController, animated: true, completion: nil)
//        })
    }
}
