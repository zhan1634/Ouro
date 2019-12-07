//
//  Generatedexp.swift
//  Ouro
//
//  Created by PC on 08/11/19.
//  Copyright © 2019 PC. All rights reserved.
//

import Foundation

//struct GeneratedModel  : Codable{
//    var Categorie
//}

struct Generatemodel 
{
    var Address : String?
    var Categories : String?
    var Latitude : String?
    var Location_Generated : Int?
    var Longitude : String?
    var Name : String?
    var Neighborhood : String?
    var Phone : String?
    var Photo : String?
    var Price : String?
    var Rating : Int?
//    init(Address : String,Categories:[String],Latitude:String,Location_Generated:Bool,Longitude:String,Name:String,Neighborhood:[String],Phone:String,Photo:String,Price:String,Rating:String ) {
//        self.Address = Address
//        self.Categories = Categories
//        self.Latitude = Latitude
//        self.Location_Generated = Location_Generated
//        self.Longitude = Longitude
//        self.Name = Name
//        self.Neighborhood = Neighborhood
//        self.Phone = Phone
//        self.Photo = Photo
//        self.Price = Price
//        self.Rating = Rating
//    }*/
    
    init(_ dic:[String:Any]){
        self.Address = dic["Address"] as? String ?? ""
        self.Categories = dic["Categories"] as? String ?? ""
        self.Latitude = dic["Latitude"] as? String ?? ""
        self.Location_Generated = dic["Location_Generated"] as? Int
        self.Longitude = dic["Longitude"] as? String ?? ""
        self.Name = dic["Name"] as? String ?? ""
        self.Neighborhood = dic["Neighborhood"] as? String ?? ""
        self.Phone = dic["Neighborhood"] as? String ?? ""
        self.Photo = dic["Photo"] as? String ?? ""
        self.Price = dic["Price"] as? String ?? ""
        self.Rating = dic["Rating"] as? Int 
    }
}
