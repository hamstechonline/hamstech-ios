//
//  AfflicationModel.swift
//  hamstech
//
//  Created by Priyanka on 21/05/20.
//

import Foundation
import UIKit


class  AfflicationResponseModel{
    
    
    var affliation_video : String!
    var affliation_data = [[String:Any]]()
   

    init(data : NSDictionary) {
        
        if let affliation_video = data["affliation_video"]{
            self.affliation_video = affliation_video as? String
        }
        if let affliation_data = data["affliation_data"]{
            self.affliation_data = affliation_data as! [[String:Any]]
        }
    }
   
}

class  AfflicationdataResponseModel{
    
    
    var affliation_image : String!
    var affliations_descriptiom: String!
   

    init(data : NSDictionary) {
        
        if let affliation_image = data["affliation_Image"]{
            self.affliation_image = affliation_image as? String
        }
        if let affliations_descriptiom = data["affliations_descriptiom"]{
            self.affliations_descriptiom = affliations_descriptiom as? String
        }
    }
   
}
