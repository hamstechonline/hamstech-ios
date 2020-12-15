//
//  LoginOtpViewController.swift
//  hamstech
//
//  Created by Priyanka on 28/04/20.
//

import UIKit
import GoogleMaps

class LoginOtpViewController: UIViewController, CLLocationManagerDelegate  {

    @IBOutlet weak var user_TextField: UITextField!
    
     var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

 ActivityServiceCalling(Pagename: "Login", Activity: "Viewd")
        
        var currentLoc: CLLocation!

        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
        CLLocationManager.authorizationStatus() == .authorizedAlways) {

        currentLoc = locationManager.location

        }

        if currentLoc == nil {

       

        } else {

        currentLoc = CLLocation(latitude: currentLoc.coordinate.latitude, longitude: currentLoc.coordinate.longitude)

        }
    }
    

    @IBAction func getOtpButtonAction(_ sender: Any) {
        
        if user_TextField.text == "" {
            
            self.customPresentAlert(withTitle: "", message: "Please Enter your Registered mobile number")
            
        } else {
           
            ActivityServiceCalling(Pagename: "Login", Activity: "getotp")
            LoginServiceCalling()
            
        }
        
    }
    
    
    @IBAction func newToHamstechButtonAction(_ sender: Any) {
        
    ActivityServiceCalling(Pagename: "Login", Activity: "newtohamstach")
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RegisterOtpViewController") as? RegisterOtpViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    func LoginServiceCalling() {
               
               if Reachability.isConnectedToNetwork(){
               let Urlname =  "\(ConstantsKeys.AppLinks.BaseUrl)\(ConstantsKeys.AppGetUrls.getotp)"
                
                
                let params  = ["page":"login","phone":user_TextField.text!,"countrycode":"91","lang":ConstantsKeys.apikey.lan] as [String : Any]
               
               
                   
                ActivityIndicatorWithLabel.shared.showProgressView(uiView: view)
               NetworkHelper.sharedInstance.postServiceCall(url: Urlname, PostDetails: params as [String : AnyObject]) { (response, error)  in

                ActivityIndicatorWithLabel.shared.hideProgressView()

                  
                if let status = response["status"] as? NSDictionary {
                    
                         let message = status["message"] as! NSDictionary
                        

                    
                        let responsecode:String =   String(message["responsecode"] as! String)


                        print(responsecode)

                        if responsecode == "OK" {

                            let metadata = status["metadata"] as! NSDictionary
                            
                       let loginResponseData = LoginResponseModel (data: status["metadata"] as! NSDictionary)
                            
                        let otphash = loginResponseData.otphash
                        let otptimestamp = metadata["timestamp"] as! NSNumber
                            
                        print("otptimestamp", otptimestamp)
                            
                        UserDefaults.standard.set(otphash, forKey: "otphash")
                        UserDefaults.standard.set(otptimestamp, forKey: "otptimestamp")
                            
                            
                      let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginVerifyViewController") as? LoginVerifyViewController
                        vc?.number = self.user_TextField.text!
                    self.navigationController?.pushViewController(vc!, animated: true)


                } else {

                    let data = status["data"] as! String

                    // let response = loginResponseData.response

                    self.customPresentAlert(withTitle: "", message: data)
                 }
                    
                }  else {
                    
                    if let status = response["status"] as? String {
                        
                        self.customPresentAlert(withTitle: "", message: status)
                        
                    }
                    
                    
                    
                }
        
               }

               }
        
               else
               {
                   self.customPresentAlert(withTitle: "", message: "Please Check Network Connection")
               }
           }
}

