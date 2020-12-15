//
//  CourseModel.swift
//  hamstech
//
//  Created by Priyanka on 09/06/20.
//

import Foundation
import UIKit


class CourseResponseModel{
    
    var courseVideo = [[String:Any]]()
    var courseCareerOptions = [[String:Any]]()
    var courseList = [[String:Any]]()
    var coursePlacements = [[String:Any]]()
    var courseWhyHamstech = [[String:Any]]()
    var courseTestimonials = [[String:Any]]()
   

    init(data : NSDictionary) {
        
       if let courseCareerOptions = data["career_options"]{
            self.courseCareerOptions = courseCareerOptions as! [[String:Any]]
        }
        if let courseList = data["course_list"]{
            self.courseList = courseList as! [[String:Any]]
        }
        if let coursePlacements = data["placements"]{
            self.coursePlacements = coursePlacements as! [[String:Any]]
        }
        if let courseWhyHamstech = data["why_hamstech"]{
            self.courseWhyHamstech = courseWhyHamstech as! [[String:Any]]
        }
        if let courseTestimonials = data["testimonials"]{
            self.courseTestimonials = courseTestimonials as! [[String:Any]]
        }
      }
   
}

class careerOptionsDataResponseModel{
    
    
    var careerId : String!
    var categoryId : String!
    var careerOptions : String!
    
   
    init(data : NSDictionary) {
        
        if let careerId = data["career_id"]{
            self.careerId = careerId as? String
        }
        
        if let categoryId = data["category_id"]{
            self.categoryId = categoryId as? String
        }
        
        if let careerOptions = data["career_options"]{
            self.careerOptions = careerOptions as? String
        }
    }
}

class courseListDataResponseModel{
    
    
    var courseName : String!
    var courseId : String!
   
     init(data : NSDictionary) {
        
        if let courseName = data["course_name"]{
            self.courseName = courseName as? String
        }
        if let courseId = data["courseId"]{
                   self.courseId = courseId as? String
               }
        
    }
}

class coursePlacementsDataResponseModel{
    
    
    var coursePlacementImages : String!
   

    init(data : NSDictionary) {
        
        if let coursePlacementImages = data["plagement_images"]{
            self.coursePlacementImages = coursePlacementImages as? String
        }
    }
}

class courseWhyHamstechDataResponseModel{
    
    
    var courseUploadImages : String!
   

    init(data : NSDictionary) {
        
        if let courseUploadImages = data["upload_images"]{
            self.courseUploadImages = courseUploadImages as? String
        }
    }
}

class courseTestimonialsDataResponseModel{
    
    
    var courseAddImage : String!
    var courseTitle : String!
    var courseDescription : String!
    var coursePosition : String!
   
    init(data : NSDictionary) {
        
        if let courseAddImage = data["add_image"]{
            self.courseAddImage = courseAddImage as? String
        }
        if let courseTitle = data["add_title"]{
            self.courseTitle = courseTitle as? String
        }
        if let courseDescription = data["add_description"]{
            self.courseDescription = courseDescription as? String
        }
        if let coursePosition = data["add_position"]{
            self.coursePosition = coursePosition as? String
        }
    }
}
   
