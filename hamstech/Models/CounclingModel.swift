//
//  CounclingModel.swift
//  hamstech
//
//  Created by Priyanka on 20/06/20.
//

import Foundation

class CounclingResponseModel{
    
    
    var counseling_id : String!
    var counseling_name : String!
    var image_url : String!
    var video_url : String!
    
   
    init(data : NSDictionary) {
        
        if let counseling_id = data["counseling_id"]{
            self.counseling_id = counseling_id as? String
        }
        
        if let counseling_name = data["counseling_name"]{
            self.counseling_name = counseling_name as? String
        }
        
        if let image_url = data["image_url"]{
            self.image_url = image_url as? String
        }
        if let video_url = data["video_url"]{
           self.video_url = video_url as? String
        }
    }
}
