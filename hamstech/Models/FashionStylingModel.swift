//
//  FashionStylingModel.swift
//  hamstech
//
//  Created by Priyanka on 09/08/20.
//

import Foundation


class FashionStylingResponseModel {
    
    
    var curriculumString : String!

    init(data : NSDictionary) {
        
        if let curriculumString = data["curriculum"]{
            self.curriculumString = curriculumString as? String
        }
    }
   
}
