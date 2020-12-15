//
//  LoginVerifyViewController.swift
//  hamstech
//
//  Created by Priyanka on 28/04/20.
//

import UIKit
import GoogleMaps
import Network
import CoreTelephony

class LoginVerifyViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate, URLSessionDelegate, URLSessionDataDelegate {
    
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var otpTextField: UITextField!
    
    @IBOutlet weak var timmer_Lbl: UILabel!
    
    var locationManager = CLLocationManager()
    var address = String()
    var city = String()
    var pincode = String()
    var state = String()
    var country = String()
    var number = String()
    var networkspeed = String()
    var networkupspeed = String()
    var networkMode = String()
    var timer: Timer?
    var last_number = String()
    var uploadTask: URLSessionUploadTask!
     
    @IBOutlet weak var whatsapp_Img: UIImageView!
    @IBOutlet weak var whatsap_Lbl: UILabel!
    @IBOutlet weak var whatsapp_But: UIButton!
    
    @IBOutlet weak var resend_But: UIButton!
    
    @IBOutlet weak var resend_Height: NSLayoutConstraint!
    
    
    typealias speedTestCompletionHandler = (_ megabytesPerSecond: Double? , _ error: Error?) -> Void

       var speedTestCompletionBlock : speedTestCompletionHandler?

       var startTime: CFAbsoluteTime!
       var stopTime: CFAbsoluteTime!
       var bytesReceived: Int!

       var otptimer = Timer()
       var seconds = 120
    
    override func viewDidLoad() {
        super.viewDidLoad()

        otptimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(otptimout), userInfo: nil, repeats: true)
    
         ActivityServiceCalling(Pagename: "Login", Activity: "viewed")
                
                numberTextField.text = number
                
                  var currentLoc: CLLocation!
                  let marker = GMSMarker()
                
                        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
                        CLLocationManager.authorizationStatus() == .authorizedAlways) {
                            
                            currentLoc = locationManager.location
                            
                              if currentLoc != nil {
                            
                                
                          //  currentLoc = locationManager.location
                            
                            
                            getAddressFromLatLon(pdblLatitude: currentLoc.coordinate.latitude, withLongitude: currentLoc.coordinate.longitude)
                                
                          //  getAddressFromLatLon(pdblLatitude: 8.100629, withLongitude: 77.438219)
                           marker.position = CLLocationCoordinate2DMake(currentLoc.coordinate.latitude,currentLoc.coordinate.longitude)
                                
                          reverseGeocoding(marker: marker)
                                
                            print("lat = \(currentLoc.coordinate.latitude)")
                            print("lon = \(currentLoc.coordinate.longitude)")
                        }
                          
                      }
        
        
       checkForSpeedTest()
      
        
        
       // networkconnection
        
        let nwPathMonitor = NWPathMonitor()
          nwPathMonitor.pathUpdateHandler = { path in
             
              if path.usesInterfaceType(.wifi) {
                  // Correctly goes to Wi-Fi via Access Point or Phone enabled hotspot
                print("wifi")
                  
                  self.networkMode = "wifi"
                  
              } else if path.usesInterfaceType(.cellular) {
                   print("Path is Cellular")
                  
                  // netwok operator name
                         
                 let networkInfo = CTTelephonyNetworkInfo()
                 let carrier = networkInfo.subscriberCellularProvider
                
                 let carriername = carrier?.carrierName
                 print("carriername", carriername)
                  
                  if carriername != nil {
                      
                      self.networkMode = carriername ?? ""
                      
                  } else {
                  
                  self.networkMode = "cellular"
                      
                  }
              } else if path.usesInterfaceType(.wiredEthernet) {
                  print("Path is Wired Ethernet")
                  self.networkMode = "Wired Ethernet"
                  
              } else if path.usesInterfaceType(.loopback) {
                  print("Path is Loopback")
                   self.networkMode = "Loopback"
                
              } else if path.usesInterfaceType(.other) {
                  
                  print("Path is other")
                  self.networkMode = "other"
              }
          }
          nwPathMonitor.start(queue: .main)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
           self.timmer_Lbl.isHidden = false
      }
    
    func timeString(time:TimeInterval) -> String {
    let hours = Int(time) / 3600
    let minutes = Int(time) / 60 % 60
    let seconds = Int(time) % 60
    return String(format:"%02i:%02i", minutes, seconds)
    }
    

    
    @objc func otptimout() {
        
        seconds -= 1
        
        if seconds == 0 {
            
        let last4 = String(number.characters.suffix(4))
            
        otpTextField.text = last4
        last_number = last4
        self.timmer_Lbl.isHidden = true
            whatsapp_Img.isHidden = false
            whatsap_Lbl.isHidden = false
            whatsapp_But.isHidden = false
            resend_But.isHidden = false
            resend_Height.constant = 54
        LoginServiceCalling()
            
            
        } else {
        
        
        timmer_Lbl.text = "OTP Expires in: \(timeString(time: TimeInterval(seconds))) Minutes"
    }
     
        
    }
    
    
    func checkForSpeedTest() {

           testDownloadSpeedWithTimout(timeout: 5.0) { (speed, error) in
            
            self.networkspeed = "\(speed ?? 0)"
            self.networkupspeed = "\(speed ?? 0 + 0.5)"
            
            
               print("Download Speed:", speed ?? "NA")
               print("Speed Test Error:", error ?? "NA")
           }

       }

    
       func testDownloadSpeedWithTimout(timeout: TimeInterval, withCompletionBlock: @escaping speedTestCompletionHandler) {

           guard let url = URL(string: "https://images.apple.com/v/imac-with-retina/a/images/overview/5k_image.jpg") else { return }

           startTime = CFAbsoluteTimeGetCurrent()
           stopTime = startTime
           bytesReceived = 0

           speedTestCompletionBlock = withCompletionBlock

           let configuration = URLSessionConfiguration.ephemeral
           configuration.timeoutIntervalForResource = timeout
           let session = URLSession.init(configuration: configuration, delegate: self, delegateQueue: nil)
           session.dataTask(with: url).resume()

       }

       func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
           bytesReceived! += data.count
           stopTime = CFAbsoluteTimeGetCurrent()
       }

       func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {

           let elapsed = stopTime - startTime

           if let aTempError = error as NSError?, aTempError.domain != NSURLErrorDomain && aTempError.code != NSURLErrorTimedOut && elapsed == 0  {
               speedTestCompletionBlock?(nil, error)
               return
           }

           let speed = elapsed != 0 ? Double(bytesReceived) / elapsed / 1024.0 / 1024.0 : -1
           speedTestCompletionBlock?(speed, nil)

       }
    

    
    /// User Address
    
    func reverseGeocoding(marker: GMSMarker) {
        let geocoder = GMSGeocoder()
        let coordinate = CLLocationCoordinate2DMake(Double(marker.position.latitude),Double(marker.position.longitude))
        
        var currentAddress = String()
        
        geocoder.reverseGeocodeCoordinate(coordinate) { response , error in
            if let address = response?.firstResult() {
                let lines = address.lines! as [String]
                
                print("Response is = \(address)")
                print("Response is = \(lines)")
                
                currentAddress = lines.joined(separator: "\n")
                
            }
            marker.title = currentAddress
           
            self.address = currentAddress
        }
    }
    
    
    
             func getAddressFromLatLon(pdblLatitude: Double, withLongitude pdblLongitude: Double) {
                 var center : CLLocationCoordinate2D = CLLocationCoordinate2D()

                 let lat: Double = pdblLatitude
                 //21.228124
                 let lon: Double = pdblLongitude
                 //72.833770
                 let ceo: CLGeocoder = CLGeocoder()
                 center.latitude = lat
                 center.longitude = lon

                 let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)

                 ceo.reverseGeocodeLocation(loc, completionHandler:
                     {(placemarks, error) in
                         if (error != nil)
                         {
                             print("reverse geodcode fail: \(error!.localizedDescription)")
                         }
                         let pm = placemarks! as [CLPlacemark]

                         if pm.count > 0 {

                             let pm = placemarks![0]
                             var addressString : String = ""

                             if pm.subLocality != nil {
                                 addressString = addressString + pm.subLocality! + ", "
     
     
                             }
                             if pm.thoroughfare != nil {
                                 addressString = addressString + pm.thoroughfare! + ", "
                             }
                             if pm.locality != nil {
                                 addressString = addressString + pm.locality! + ", "
     
                                  self.city = pm.locality ?? ""
                             }
                             if pm.country != nil {
                                 addressString = addressString + pm.country! + ", "
     
                                 self.country =  pm.country ?? ""
                             }
                             if pm.postalCode != nil {
                                 addressString = addressString + pm.postalCode! + " "
     
                                 self.pincode =  pm.postalCode ?? ""
     
                             }
     
                             if pm.administrativeArea != nil {
                                 addressString = addressString + pm.postalCode! + " "
     
                                 self.state =  pm.administrativeArea ?? ""
     
                             }
    

                       }
                 })

             }
    
    
    
    
    
    
    
    @IBAction func resendButtonAction(_ sender: Any) {
        
        if !isValidPhone(phone: numberTextField.text ?? "") {
            
            self.customPresentAlert(withTitle: "", message: "Please enter Valid Mobile Number")
            
        } else {
           
             ActivityServiceCalling(Pagename: "Login", Activity: "resendotp")
             resendServiceCalling()
           
        }
    
        
    }
    
    
    @IBAction func verifyButtonAction(_ sender: Any) {
        
    
        if otpTextField.text == "" {
            self.customPresentAlert(withTitle: "", message: "Please enter Otp")
            
        }else {
            
         ActivityServiceCalling(Pagename: "Login", Activity: "verifyotp")
         LoginServiceCalling()
            
        }
// let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController
//  self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    @IBAction func newToHamstechButtonAction(_ sender: Any) {
        
        ActivityServiceCalling(Pagename: "Login", Activity: "newtohamstach")
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RegisterOtpViewController") as? RegisterOtpViewController
               self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    

    
    func LoginServiceCalling() {


               let otptimestamp: Int = UserDefaults.standard.object(forKey: "otptimestamp") as? Int ?? 0
        
        print("otptimestamp", otptimestamp)
        
               let fcmToken: String = UserDefaults.standard.object(forKey: "fcmToken") as? String ?? ""
               
               
                  if Reachability.isConnectedToNetwork(){
                  let Urlname =  "\(ConstantsKeys.AppLinks.BaseUrl)\(ConstantsKeys.AppGetUrls.verifylogin)"
                 
                    let params  = ["appname":ConstantsKeys.apikey.appname,"apikey":ConstantsKeys.apikey.api_key,"page":"login","name":"","phone":numberTextField.text!,"cityName":city,"user_address":address,"user_state":state,"user_pincode":pincode,"user_country":pincode,"otp":otpTextField.text!,"otptimestamp":otptimestamp,"gcm_id":fcmToken,"countrycode":"91","lang":ConstantsKeys.apikey.lan,"device":"ios","networkconnection": self.networkMode, "downSpeed": self.networkspeed, "upSpeed": self.networkupspeed,"last_number": last_number] as [String : Any]
                   
                     print("params = \(params)")
                   

           ActivityIndicatorWithLabel.shared.showProgressView(uiView: view)
           NetworkHelper.sharedInstance.postServiceCall(url: Urlname, PostDetails: params as [String : AnyObject]) { (response, error)  in

           ActivityIndicatorWithLabel.shared.hideProgressView()

             if let status = response["status"] as? NSDictionary {
            let data = status["data"] as! NSDictionary
            let status1 = status["status"] as! NSDictionary
            
            let message:String =   String(data["message"] as! String)
                let status2 =  status1["status"] as! NSNumber
             

            if status2 == 200 {

                 self.timer?.invalidate()
                
                let prospectname:String =   String(data["name"] as! String)
                
               // let profilepic:String =   String(data["profilepic"] as! String)
                
                print("prospectname", prospectname)
                
                UserDefaults.standard.set("Userlogedin", forKey: "logedin")
                
                
                UserDefaults.standard.set(self.numberTextField.text!, forKey: "phonenumber")
                UserDefaults.standard.set(prospectname, forKey: "prospectname")
               // UserDefaults.standard.set(profilepic, forKey: "profilepic")
                
                
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController
                self.navigationController?.pushViewController(vc!, animated: true)
                

            } else {

                
                self.seconds = 120
                self.otpTextField.text = ""

                self.customPresentAlert(withTitle: "", message: message)
                } } else {
                
                
                if let status = response["status"] as? String {
                   
                     self.customPresentAlert(withTitle: "", message: (status) as String)
                    
                }
                
                }

            
           }

           }
    
           else
           {
               self.customPresentAlert(withTitle: "", message: "Please Check Network Connection")
           }
       }
    
    
    func resendServiceCalling() {
        
       
        
                     if Reachability.isConnectedToNetwork(){
                     let Urlname =  "\(ConstantsKeys.AppLinks.BaseUrl)\(ConstantsKeys.AppGetUrls.getotp)"
                      
                      
                        let params  = ["appname":ConstantsKeys.apikey.appname,"apikey":ConstantsKeys.apikey.api_key,"page":"login","name":"","phone":numberTextField.text!,"countrycode":"91","lang":ConstantsKeys.apikey.lan] as [String : Any]
                    
                       
                         
                      ActivityIndicatorWithLabel.shared.showProgressView(uiView: view)
                     NetworkHelper.sharedInstance.postServiceCall(url: Urlname, PostDetails: params as [String : AnyObject]) { (response, error)  in

                     ActivityIndicatorWithLabel.shared.hideProgressView()

                       if let status = response["status"] as? NSDictionary {
                        
                       let message = status["message"] as! NSDictionary
                       
                        let responsecode:String =   String(message["responsecode"] as! String)
                      
                       
                       print(responsecode)
                       
                       if responsecode == "OK" {
                           
                      let loginResponseData = LoginResponseModel (data: status["metadata"] as! NSDictionary)

                      let otphash = loginResponseData.otphash
                      let otptimestamp = loginResponseData.otptimestamp

                      UserDefaults.standard.set(otphash, forKey: "otphash")
                      UserDefaults.standard.set(otptimestamp, forKey: "otptimestamp")
                        
                         let data = status["data"] as! String
                         self.customPresentAlert(withTitle: "", message: data)
                          self.seconds = 120
                           
                       } else {
                         
                           let data = status["data"] as! String
                           
                          //  let response:String =   String(data["response"] as! String)
                    
                        self.customPresentAlert(withTitle: "", message: data)
                        } } else {
                        
                        
                        if let status = response["status"] as? String {
                           
                             self.customPresentAlert(withTitle: "", message: (status) as String)
                            
                        }
                        
                        }

                      
                     }

                     }
              
                     else
                     {
                         self.customPresentAlert(withTitle: "", message: "Please Check Network Connection")
                     }
                 }
    
    @IBAction func wa_Action(_ sender: Any) {
       
        
        let phoneNumber =  "+919010100240"
        let appURL = URL(string: "https://api.whatsapp.com/send?phone=\(phoneNumber)")!
        if UIApplication.shared.canOpenURL(appURL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
            }
            else {
                UIApplication.shared.openURL(appURL)
            }
        } else {
          self.view.window?.makeToast("Whatsapp is not Installed", duration: 2.0, position: CSToastPositionCenter)
        }
        
    }
    
    
}
