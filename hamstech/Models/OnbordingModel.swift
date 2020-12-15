//
//  OnbordingModel.swift
//  hamstech
//
//  Created by Priyanka on 05/06/20.
//

import Foundation
import UIKit


class  OnBordingResponseModel{
    
    
    var upload_images : String!

    init(data : NSDictionary) {
        
        if let upload_images = data["upload_images"]{
            self.upload_images = upload_images as? String
        }
    }
   
}
