//
//  MentoresModel.swift
//  hamstech
//
//  Created by Priyanka on 23/05/20.
//

import Foundation
import UIKit

class  MentorsdataResponseModel{
    
    
    var mentor_image : String!
    var mentors_title: String!
    var mentorss_description: String!
   

    init(data : NSDictionary) {
        
        if let mentor_image = data["mentor_image"]{
            self.mentor_image = mentor_image as? String
        }
        if let mentors_title = data["mentors_title"]{
            self.mentors_title = mentors_title as? String
        }
        if let mentorss_description = data["mentorss_description"]{
            self.mentorss_description = mentorss_description as? String
        }
    }
   
}
