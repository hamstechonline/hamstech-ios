//
//  SearchModel.swift
//  hamstech
//
//  Created by Priyanka on 20/06/20.
//

import Foundation

class SearchResponseModel{
    
    
    var course_name : String!
    var image_url : String!
    var courseId : String!
    var categoryId : String!
    var categoryname : String!
    var coursename_categoryname : String!
    var amount : String!
    
  
    init(data : NSDictionary) {
        
        if let course_name = data["course_name"]{
            self.course_name = course_name as? String
        }
        
        if let image_url = data["image_url"]{
            self.image_url = image_url as? String
        }
        
        if let courseId = data["courseId"]{
            self.courseId = courseId as? String
        }
        if let categoryId = data["categoryId"]{
           self.categoryId = categoryId as? String
        }
        
        if let categoryname = data["categoryname"]{
           self.categoryname = categoryname as? String
            
            self.coursename_categoryname = "\(self.categoryname!)-\(self.course_name!)"
            
        }
        
        if let amount = data["amount"]{
           self.amount = amount as? String
            
          
        }
        
    }
}
