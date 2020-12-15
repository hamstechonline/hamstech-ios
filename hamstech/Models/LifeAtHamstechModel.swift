//
//  LifeAtHamstechModel.swift
//  hamstech
//
//  Created by Priyanka on 27/05/20.
//

import Foundation
import UIKit


class  LifeAtHamstechResponseModel{
    
    
    var lifeAtHamstech_video : String!
    var lifeAtHamstech_gallery = [[String:Any]]()
    var lifeAtHamstech_events = [[String:Any]]()
   

    init(data : NSDictionary) {
        
        if let lifeAtHamstech_video = data["hamstech_videos"]{
            self.lifeAtHamstech_video = lifeAtHamstech_video as? String
        }
        if let lifeAtHamstech_gallery = data["hamstech_gallery"]{
            self.lifeAtHamstech_gallery = lifeAtHamstech_gallery as! [[String:Any]]
        }
        if let lifeAtHamstech_events = data["hamstech_events"]{
            self.lifeAtHamstech_events = lifeAtHamstech_events as! [[String:Any]]
        }
    }
   
}

class  LifeAtHamstechgalleryResponseModel{
    
    
    var LifeAtHamstech_image : String!
   
    init(data : NSDictionary) {
        
        if let LifeAtHamstech_image = data["add_image"]{
            self.LifeAtHamstech_image = LifeAtHamstech_image as? String
        }
        
    }
}

class  LifeAtHamstecheventsResponseModel{
    
    
    var LifeAtHamstech_title : String!
    var LifeAtHamstech_addimage : String!
    
   
    init(data : NSDictionary) {
        
        if let LifeAtHamstech_title = data["add_title"]{
            self.LifeAtHamstech_title = LifeAtHamstech_title as? String
        }
        
        if let LifeAtHamstech_addimage = data["add_image"]{
            self.LifeAtHamstech_addimage = LifeAtHamstech_addimage as? String
        }
        
    }
}

