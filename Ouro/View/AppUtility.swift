//
//  AppUtility.swift
//  Ouro
//
//  Created by PC on 05/11/19.
//  Copyright © 2019 PC. All rights reserved.
//

import Foundation
import UIKit
class AppUtility: NSObject {

class func GetLoginUserData() -> UserDetail?
{
    let data = UserDefaults.standard.value(forKey: "Userdata") as? Data
    let userdata = try? JSONDecoder().decode(UserDetail.self, from: data!)
    return userdata!
}

    
}

