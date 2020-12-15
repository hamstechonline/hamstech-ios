//
//  AboutUsModel.swift
//  hamstech
//
//  Created by Priyanka on 27/05/20.
//

import Foundation
import UIKit


class AboutUsResponseModel{
    
    
    var aboutus_video : String!
    var ajitha_image : String!
    var ajitha_yogesh_colored_text : String!
    var ajitha_yogesh_text : String!
    var our_history : String!
    var aboutus_data = [[String:Any]]()
   

    init(data : NSDictionary) {
        
        if let aboutus_video = data["aboutus_video"]{
            self.aboutus_video = aboutus_video as? String
        }
        if let ajitha_image = data["ajitha_image"]{
            self.ajitha_image = ajitha_image as? String
        }
        if let ajitha_yogesh_colored_text = data["ajitha_yogesh_colored_text"]{
            self.ajitha_yogesh_colored_text = ajitha_yogesh_colored_text as? String
        }
        if let ajitha_yogesh_text = data["ajitha_yogesh_text"]{
            self.ajitha_yogesh_text = ajitha_yogesh_text as? String
        }
        if let our_history = data["our_history"]{
            self.our_history = our_history as? String
        }
        if let aboutus_data = data["why_hamstech_images"]{
            self.aboutus_data = aboutus_data as! [[String:Any]]
        }
    }
   
}

class  AboutUsDataResponseModel{
    
    
    var upload_images : String!
   
    init(data : NSDictionary) {
        
        if let upload_images = data["upload_images"]{
            self.upload_images = upload_images as? String
        }
       }
   
}






