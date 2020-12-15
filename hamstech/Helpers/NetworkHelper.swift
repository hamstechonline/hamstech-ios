//
//  LifeAtHamstechViewController.swift
//  hamstech
//
//  Created by Priyanka on 15/05/20.
//



import UIKit
import Alamofire

class NetworkHelper: NSObject {

    static let sharedInstance = NetworkHelper()
    
    
    //MARK:- GET SERVICE CALL
    func getDataServiceCall(url:String,postDict:[String:AnyObject], completionHandler : @escaping (Dictionary<String, Any>, NSError?) -> ())
    {
        
        Alamofire.request(url, method: .get, parameters: postDict).responseJSON { response in
            
        print("url ",url)
         //  print(response)
            
        switch response.result {
        case .failure:
                
          print("error")
        case .success:
              // handle success here
            completionHandler(((response.result.value as? Dictionary<String, Any>)!), response.result.error as NSError?)
        }
            
            #if DEBUG
            
          
            #endif
        }
    }
  
        
    //MARK:- POST SERVICE
    func postServiceCall(url:String,PostDetails: [String:AnyObject], completionHandler : @escaping (Dictionary<String, Any>, NSError?) -> ()){
        
         
        Alamofire.request(url, method: .post, parameters: PostDetails, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            
            print(response)
            switch response.result {
                
            case .failure:
               print("error")
            case .success:
              // handle success here
              completionHandler(((response.result.value as? Dictionary<String, Any>)!), response.result.error as NSError?)
            }
            #if DEBUG
            
            
            #endif
        }
    }
    
}





