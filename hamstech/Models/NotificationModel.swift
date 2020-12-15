//
//  NotificationModel.swift
//  hamstech
//
//  Created by Priyanka on 28/05/20.
//

import Foundation
import UIKit

class  NotificationdataResponseModel{
    
    var notification_title: String!
    var notification_description: String!
    var notification_image : String!
   

    init(data : NSDictionary) {
        
        if let notification_title = data["title"]{
            self.notification_title = notification_title as? String
        }
        if let notification_description = data["description"]{
            self.notification_description = notification_description as? String
        }
        if let notification_image = data["image"]{
            self.notification_image = notification_image as? String
        }
        
    }
   
}
