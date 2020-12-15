//
//  HomeModel.swift
//  hamstech
//
//  Created by Priyanka on 29/05/20.
//

import Foundation
import UIKit


class  HomeResponseModel{
    
    var homePageSlider = [[String:Any]]()
    var courseDetails = [[String:Any]]()
    var mentorDetails = [[String:Any]]()
    var whyHamstech = [[String:Any]]()
    var placements = [[String:Any]]()
    var affliationsSlider = [[String:Any]]()
    var testimonials = [[String:Any]]()
   

    init(data : NSDictionary) {
        
        if let homePageSlider = data["Home_page_slider"]{
            self.homePageSlider = homePageSlider as! [[String:Any]]
        }
        if let courseDetails = data["course_details"]{
            self.courseDetails = courseDetails as! [[String:Any]]
        }
        if let mentorDetails = data["mentors_details"]{
            self.mentorDetails = mentorDetails as! [[String:Any]]
        }
        if let whyHamstech = data["why_hamstech"]{
            self.whyHamstech = whyHamstech as! [[String:Any]]
        }
        if let placements = data["placements"]{
            self.placements = placements as! [[String:Any]]
        }
        if let affliationsSlider = data["affliations_slider"]{
            self.affliationsSlider = affliationsSlider as! [[String:Any]]
        }
        if let testimonials = data["testimonials"]{
            self.testimonials = testimonials as! [[String:Any]]
        }
    }
   
}

class  homePageSliderDataResponseModel{
    
    
    var sliderImage : String!
   
    init(data : NSDictionary) {
        
        if let sliderImage = data["slider_images"]{
            self.sliderImage = sliderImage as? String
        }
        
    }
}

class  courseDetailsDataResponseModel{
    
    
    var courseId : String!
    var courseName : String!
    var courseImage : String!
    var categoryId : String!
    var categoryname : String!
   
    init(data : NSDictionary) {
        
        if let courseId = data["categoryId"]{
            self.courseId = courseId as? String
        }
        
        if let courseName = data["categoryname"]{
            self.courseName = courseName as? String
        }
        
        if let courseImage = data["cat_image_url"]{
            self.courseImage = courseImage as? String
        }
        
        if let categoryId = data["categoryId"]{
                  self.categoryId = categoryId as? String
              }
        
        if let categoryId = data["categoryId"]{
                     self.categoryId = categoryId as? String
                 }
        
        if let categoryname = data["categoryname"]{
                self.categoryname = categoryname as? String
                        }
        
    }
}

class  mentorsDetailsDataResponseModel{
    
    
    var mentorsImage : String!
    var mentorsDescription : String!
    var mentorsTitle : String!
    
   
    init(data : NSDictionary) {
        
        if let mentorsImage = data["mentor_image"]{
            self.mentorsImage = mentorsImage as? String
        }
        
        if let mentorsDescription = data["mentorss_description"]{
            self.mentorsDescription = mentorsDescription as? String
        }
        
        if let mentorsTitle = data["mentors_title"]{
            self.mentorsTitle = mentorsTitle as? String
        }
    }
}

class  whyHamstechDataResponseModel{
    
    
    var uploadImages : String!
   

    init(data : NSDictionary) {
        
        if let uploadImages = data["upload_images"]{
            self.uploadImages = uploadImages as? String
        }
    }
}

class  placementsDataResponseModel{
    
    
    var placementImages : String!
   

    init(data : NSDictionary) {
        
        if let placementImages = data["plagement_images"]{
            self.placementImages = placementImages as? String
        }
    }
}

class  affliationsDataResponseModel{
    
    
    var affliationImages : String!
    var affliationDescription : String!
   

    init(data : NSDictionary) {
        
        if let affliationImages = data["affliation_Image"]{
            self.affliationImages = affliationImages as? String
        }
        if let affliationDescription = data["affliations_descriptiom"]{
            self.affliationDescription = affliationDescription as? String
        }
    }
}

class  testimonialsDataResponseModel{
    
    
    var affliationImages : String!
    var affliationTitle : String!
    var affliationDescription : String!
    var affliationPosition : String!
    
   

    init(data : NSDictionary) {
        
        if let affliationImages = data["add_image"]{
            self.affliationImages = affliationImages as? String
        }
        if let affliationTitle = data["add_title"]{
            self.affliationTitle = affliationTitle as? String
        }
        if let affliationDescription = data["add_description"]{
            self.affliationDescription = affliationDescription as? String
        }
        if let affliationPosition = data["add_position"]{
            self.affliationPosition = affliationPosition as? String
        }
    }
}
   

