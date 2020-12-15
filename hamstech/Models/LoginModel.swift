//
//  LoginModel.swift
//  hamstech
//
//  Created by Priyanka on 26/05/20.
//

import Foundation
import UIKit


class  LoginResponseModel{
    
    
    var otphash : String!
    var otptimestamp : Int!
    var page : String!
    var response : String!
   

    init(data : NSDictionary) {
        
        if let otphash = data["otphash"]{
        self.otphash = otphash as? String
        }
        if let otptimestamp = data["timestamp"]{
        self.otptimestamp = otptimestamp as? Int
        }
        if let page = data["page"]{
        self.page = page as? String
        }
        if let response = data["response"]{
        self.response = response as? String
        }

        }
}


class  ProfileResponseModel{
    
  
    var page: String!
    var phone: String!
    var prospectid: String!
    var prospectname: String!
    var profilepic: String!
    var email: String!
    var city: String!
    var occupation: String!
    var ageband: String!
    var whyhamstech: String!
    var address: String!
    var state: String!
    var pincode: String!
    var country: String!
    var gcm_id: String!
    var lang: String!
   

    init(data : NSDictionary) {
        
        if let page = data["page"]{
        self.page = page as? String
        }
        if let phone = data["phone"]{
        self.phone = phone as? String
        }
        if let prospectid = data["prospectid"]{
        self.prospectid = prospectid as? String
        }
        if let prospectname = data["prospectname"]{
        self.prospectname = prospectname as? String
        }
        if let profilepic = data["profilepic"]{
        self.profilepic = profilepic as? String
        }
        if let email = data["email"]{
        self.email = email as? String
        }
        if let city = data["city"]{
        self.city = city as? String
        }
        if let occupation = data["occupation"]{
        self.occupation = occupation as? String
        }
        if let ageband = data["ageband"]{
        self.ageband = ageband as? String
        }
        if let whyhamstech = data["whyhamstech"]{
        self.whyhamstech = whyhamstech as? String
        }
        if let address = data["address"]{
        self.address = address as? String
        }
        if let state = data["state"]{
        self.state = state as? String
        }
        if let pincode = data["pincode"]{
        self.pincode = pincode as? String
        }
        if let country = data["country"]{
        self.country = country as? String
        }
        if let gcm_id = data["gcm_id"]{
        self.gcm_id = gcm_id as? String
        }
        if let lang = data["lang"]{
        self.lang = lang as? String
        }

        }
}
