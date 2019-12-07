//
//  UserModel.swift
//  Ouro
//
//  Created by PC on 05/11/19.
//  Copyright © 2019 PC. All rights reserved.
//

import Foundation
class CurrentUser: NSObject
{
    var generalDetails: UserDetail = UserDetail()
   
    static let sharedInstance = CurrentUser()
    fileprivate override init(){
        super.init()
    }
}
struct UserDetail:Codable {
    var fname : String!
    var lname : String!
    var mobileno : String!
    var email : String!
    var password : String!
    var Familarfrenches : String?
    var LocalFamilar : String!
    var QuickEasy : String!
    var TravelDistance : Int!
    var newexperiance : String!
    var pricerange : String!
     var vegetarian : String!
    
}
