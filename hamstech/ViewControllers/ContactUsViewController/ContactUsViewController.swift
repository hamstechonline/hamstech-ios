//
//  ContactUsViewController.swift
//  hamstech
//
//  Created by Priyanka on 29/04/20.
//

import UIKit
import GoogleMaps
import SideMenu

struct Data1 {
    
    let location: CLLocation
    let area: String
    let address1: String
    let address2: String
    var city: String
    var Phone: String
    var Email: String

}

class ContactUsViewController: UIViewController, GMSMapViewDelegate,CLLocationManagerDelegate {

   @IBOutlet weak var scrollView: UIScrollView!
        
   @IBOutlet weak var contentView: UIView!
        
   @IBOutlet weak var bgPhoneNumberView: UIView!
        
   @IBOutlet weak var requestCallBackButton: UIButton!
        
   @IBOutlet weak var bgclosestCentresView: UIView!

    @IBOutlet weak var contactus_Map: GMSMapView!
    @IBOutlet weak var address_Lbl: UILabel!
    @IBOutlet weak var back_Bu: UIButton!
    
       var marker1 = GMSMarker()
      var markers = [GMSMarker]()
       var locationManager = CLLocationManager()
       var lat = Double()
       var lon  = Double()
       var fromsidemenu = Bool()
    
    var dataArray = [Data1]()
    
       let data1 = Data1(location: CLLocation(latitude: 17.409634, longitude: 78.485407), area: "Himayatnagar", address1: "II, III & IV Floor, R.K. Plaza", address2: "HIMAYATNAGAR MAIN ROAD", city: "Hyderabad – 82 India", Phone: "PHONE: +91-7416066555", Email: "EMAIL: info@hamstech.com")

       let data2 = Data1(location: CLLocation(latitude: 17.436826, longitude: 78.453033), area: "Punjagutta", address1: "3RD FLOOR, OM TOWERS, OPPOSITE MCDONALD’S", address2: "Punjagutta ‘X’ Road", city: "HYDERABAD-29 India", Phone: "PHONE: +91-40-66684994, +91-40-66684995", Email: "EMAIL: info@hamstech.com")

       let data3 = Data1(location: CLLocation(latitude: 17.438766, longitude: 78.409774), area: "Jubilee Hills", address1: "Plot No 472, 2nd Floor, SAI Galleria", address2: "Above Nissan Showroom, Road No 36", city: "Hyderabad – 500033 India", Phone: "PHONE:+91-7207057291", Email: "EMAIL: info@hamstech.com")

       
       let data4 = Data1(location: CLLocation(latitude: 17.450836, longitude: 78.489081), area: "Secunderabad", address1: "II Floor, Jade Arcade", address2: "Paradise ‘X’ Road, M.G. Road", city: "Secunderabad – 03 India", Phone: "PHONE:+91-40-66484997, +91-40-66484998", Email: "EMAIL: info@hamstech.com")

       
       let data5 = Data1(location: CLLocation(latitude: 17.490768, longitude: 78.389206), area: "Kukatpally", address1: "3rd and 4th floor, above Neerus", address2: "Forum Mall circle JNTU road", city: "Hyderabad – 72 India", Phone: "PHONE:+91-04023155963", Email: "EMAIL: info@hamstech.com")

       
       let data6 = Data1(location: CLLocation(latitude: 17.442345, longitude: 78.369605), area: "Gachibowli", address1: "4th Floor, Vamsiram builders", address2: "Jyothi Imperial, Above South India Mall", city: "Hyderabad – 32 India", Phone: "PHONE:+91-7207599222", Email: "EMAIL: info@hamstech.com")
       
       let data7 = Data1(location: CLLocation(latitude: 17.370879, longitude: 78.543669), area: "Kothapet", address1: "4th Floor, Above More Mega Store", address2: "Beside Astalakshmi Temple Arch", city: "Hyderabad – 35 India", Phone: "PHONE:+91 40  2403 4994", Email: "EMAIL: info@hamstech.com")
       
       
    
    
        override func viewDidLoad() {
            super.viewDidLoad()

            locations()
            
            ActivityServiceCalling(Pagename: "Contactus", Activity: "Viewed")
            
            if fromsidemenu == true {
              
              back_Bu.isHidden = false
              
          } else {
              
             back_Bu.isHidden = true
          }
            
              self.scrollView.addSubview(contentView)
              self.contentView.addSubview(bgPhoneNumberView)
              self.contentView.addSubview(requestCallBackButton)
              self.contentView.addSubview(bgclosestCentresView)
              self.scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 950)
            
             applyShadowOnView(bgPhoneNumberView)
             applyShadowOnView(bgclosestCentresView)
             applyShadowOnView(contactus_Map)
            
            
                   self.locationManager.delegate = self
                  // self.locationManager.startUpdatingLocation()
            
                    let Himayatnagar = CLLocation(latitude: 17.409634, longitude: 78.485407)
                    let Punjagutta = CLLocation(latitude: 17.436826, longitude: 78.453033)
                    let JubileeHills = CLLocation(latitude: 17.438766, longitude: 78.409774)
                    let Secunderabad = CLLocation(latitude: 17.450836, longitude: 78.489081)
                    let Kukatpally = CLLocation(latitude: 17.490768, longitude: 78.389206)
                    let Gachibowli = CLLocation(latitude: 17.442345, longitude: 78.369605)
                    let Kothapet = CLLocation(latitude: 17.370879, longitude: 78.543669)

                   let coordinates = [Himayatnagar, Punjagutta, JubileeHills, Secunderabad, Kukatpally, Gachibowli, Kothapet]

                   var currentLoc: CLLocation!
                   
                   if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
                   CLLocationManager.authorizationStatus() == .authorizedAlways) {
                       
                   currentLoc = locationManager.location
                       
                   }
                   
                   if currentLoc == nil {
                       
                       currentLoc = CLLocation(latitude: 17.438766, longitude: 78.453033)
                       
                   } else {
                      
                       currentLoc = CLLocation(latitude: currentLoc.coordinate.latitude, longitude: currentLoc.coordinate.longitude)
                       
                   }
                   
                  // let userLocation = CLLocation(latitude: 17.4435, longitude: 78.3772)

                   let closest = coordinates.min(by: { $0.distance(from: currentLoc) < $1.distance(from: currentLoc) })
            
                   let lan = closest?.coordinate
                   
                   let lat1 = lan?.latitude
                   let lon1 = lan?.longitude
                   
                
                   marker1.position = CLLocationCoordinate2DMake(lat1!,lon1!)
                   contactus_Map.delegate = self
                   contactus_Map.isMyLocationEnabled = true
                  // contactus_Map.settings.scrollGestures = false
            
                  // marker1.map = contactus_Map
                   contactus_Map.camera = GMSCameraPosition.camera(withTarget: marker1.position, zoom: 11)
                   lat = lat1!
                   lon = lon1!
            
                 //  getAddressFromLatLon(pdblLatitude: lat, withLongitude: lon)
                   
                   let dataArray = [data1,data2,data3,data4,data5,data6,data7]
                   
                   
                    for i in 0..<dataArray.count {
                       let closerlocation = dataArray[i].location.coordinate
                       let closerlat = closerlocation.latitude
                       
                       if closerlat == lat1! {
                        
                        address_Lbl.text = "\(dataArray[i].address1), " + " \(dataArray[i].address2), " +  " \(dataArray[i].area), " + " \(dataArray[i].city),"  + " \(dataArray[i].Email),"  + " \(dataArray[i].Phone)."
        
                       self.marker1.title = dataArray[i].area
                       self.marker1.map = self.contactus_Map
                       contactus_Map.selectedMarker = marker1
                           
                       
                       }
                    }
            
            
            
            
        }
    
    
    func locations(){
        
        let data1 = Data1(location: CLLocation(latitude: 17.409634, longitude: 78.485407), area: "Himayatnagar", address1: "II, III & IV Floor, R.K. Plaza,", address2: "HIMAYATNAGAR MAIN ROAD", city: "Hyderabad – 82 India.", Phone: "PHONE: +91-7416066555", Email: "EMAIL: info@hamstech.com")

        let data2 = Data1(location: CLLocation(latitude: 17.436826, longitude: 78.453033), area: "Punjagutta", address1: "3RD FLOOR, OM TOWERS, OPPOSITE MCDONALD’S,", address2: "Punjagutta ‘X’ Road, Punjagutta,", city: "HYDERABAD-29 India.", Phone: "PHONE: +91-40-66684994, +91-40-66684995", Email: "EMAIL: info@hamstech.com")

        let data3 = Data1(location: CLLocation(latitude: 17.438766, longitude: 78.409774), area: "Jubilee Hills", address1: "Plot No 472, 2nd Floor, SAI Galleria,", address2: "Above Nissan Showroom, Road No 36,", city: "Hyderabad – 500033 India.", Phone: "PHONE:+91-7207057291", Email: "EMAIL: info@hamstech.com")

        
        let data4 = Data1(location: CLLocation(latitude: 17.450836, longitude: 78.489081), area: "Secunderabad", address1: "II Floor, Jade Arcade,", address2: "Paradise ‘X’ Road, M.G. Road,", city: "Secunderabad – 03 India.", Phone: "PHONE:+91-40-66484997, +91-40-66484998", Email: "EMAIL: info@hamstech.com")

        
        let data5 = Data1(location: CLLocation(latitude: 17.490768, longitude: 78.389206), area: "Kukatpally", address1: "3rd and 4th floor, above Neerus,", address2: "Forum Mall circle JNTU road,", city: "Kukatpally Hyderabad – 72 India.", Phone: "PHONE:+91-04023155963", Email: "EMAIL: info@hamstech.com")

        
        let data6 = Data1(location: CLLocation(latitude: 17.442345, longitude: 78.369605), area: "Gachibowli", address1: "4th Floor, Vamsiram builders,", address2: "Jyothi Imperial, Above South India Mall,", city: "Hyderabad – 32 India", Phone: "PHONE:+91-7207599222", Email: "EMAIL: info@hamstech.com")
        
        let data7 = Data1(location: CLLocation(latitude: 17.370879, longitude: 78.543669), area: "Kothapet", address1: "4th Floor, Above More Mega Store,", address2: "Beside Astalakshmi Temple Arch,", city: "/Hyderabad – 35 India.", Phone: "PHONE:+91 40  2403 4994", Email: "EMAIL: info@hamstech.com")
        
        
        let data = [data1,data7,data3,data4,data5,data6,data2]
        
         for i in data {
            
          self.dataArray.append(i)
          
          self.branches()
            
        }

        
    }
    
    
    func branches(){
  
        let marker = GMSMarker()
        
        for i in dataArray {
          
          let location = i.location
          
          let lat: CLLocationDegrees =  location.coordinate.latitude
          let lon: CLLocationDegrees = location.coordinate.longitude
            
            marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lon)
          
            marker.map = contactus_Map
            contactus_Map.isMyLocationEnabled = true
    
            contactus_Map.delegate = self
          

           // campous_Map.settings.scrollGestures = false
            contactus_Map.camera = GMSCameraPosition.camera(withTarget: marker.position, zoom: 11)
          
          //  campous_Map.setMinZoom(11, maxZoom: 11)
            marker.title = i.area
          //  marker.infoWindowAnchor = CGPoint(x: 0.5, y: 0.2)
          //  marker.accessibilityLabel = "\(i.area)"
           // campous_Map.selectedMarker = markers
          
      
        }

        
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        markers.append(marker)
      
      
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
             self.navigationController?.navigationBar.isHidden = true
         }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        
//           if(mapView.camera.zoom <= 11) {
//         
//            contactus_Map.settings.scrollGestures = false
//           
//            
//        } else {
//            
//            contactus_Map.settings.scrollGestures = true
//        }
    }
    
    
        
    @IBAction func call_Action(_ sender: Any) {
        ActivityServiceCalling(Pagename: "Contactus", Activity: "Call")
        
        if let phoneCallURL = URL(string: "tel://\(+9010100240)"), UIApplication.shared.canOpenURL(phoneCallURL)
        {
            UIApplication.shared.open(phoneCallURL, options: [:], completionHandler: nil)
        }
        
    }
    
        
        @IBAction func requestCallBackButtonActin(_ sender: Any) {
            
            self.contactUsServiceCalling()
        }
    
    @IBAction func whatsAppAction(_ sender: Any) {
       
        ActivityServiceCalling(Pagename: "Contactus", Activity: "Chat")
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
    
    @IBAction func searchAction(_ sender: Any) {
      
        ActivityServiceCalling(Pagename: "ContactUs", Activity: "Search")
        
        let story = UIStoryboard.init(name: "Main", bundle: nil)
        let cartVC = story.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController

        var viewcontroller = UIApplication.shared.keyWindow?.rootViewController
        let navigation = UINavigationController.init(rootViewController: cartVC)
        navigation.modalPresentationStyle = .overCurrentContext
        while ((viewcontroller?.presentedViewController) != nil){
        viewcontroller = viewcontroller?.presentedViewController
        }
        viewcontroller?.present(navigation, animated: false, completion: nil)
        
        
    }
    
    @IBAction func sideMenuAction(_ sender: Any) {
         present(SideMenuManager.default.menuRightNavigationController!, animated: true, completion: nil)
    }
    
    @IBAction func backButtonAction(_ sender: Any){
        
       
        self.navigationController?.popViewController(animated: true)
    }
    
    func contactUsServiceCalling()
        {
        
            if Reachability.isConnectedToNetwork(){
                             let Urlname = "\(ConstantsKeys.AppLinks.BaseUrl)\(ConstantsKeys.AppGetUrls.requestcallback)"

                                       let params  = ["leadid":"6252862f-ac4c-4899-8fc0-2751fe34588c","appname":ConstantsKeys.apikey.appname, "apikey": ConstantsKeys.apikey.api_key]  as [String : Any]
                                
               
                
                            ActivityIndicatorWithLabel.shared.showProgressView(uiView: view)
                            NetworkHelper.sharedInstance.postServiceCall(url: Urlname, PostDetails: params as [String : AnyObject]) { (response, error)  in

                            ActivityIndicatorWithLabel.shared.hideProgressView()

                              let status = response["status"] as! NSDictionary
                              let message:String = String(status["messsage"] as! String)
                             
                              if message == "Callback Request Shared Successfully" {
                                  
                              self.customPresentAlert(withTitle: "Request Received!", message:"You will receive a call from us shortly")
                                
                             
                        
                              } else {
                                
    
                                 self.customPresentAlert(withTitle: "", message:"Request Failed")
                                
                                
                              }

                             
                            }

                            }
                     
                            else
                            {
                                self.customPresentAlert(withTitle: "", message: "Please Check Network Connection")
                            }
                        }
              
              
              
                
    }


