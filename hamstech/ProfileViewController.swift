//
//  ProfileViewController.swift
//  hamstech
//
//  Created by Priyanka on 15/05/20.
//

import UIKit
import GoogleMaps
import SideMenu
import Alamofire
import SDWebImage

class ProfileViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, GMSMapViewDelegate,CLLocationManagerDelegate, UITextViewDelegate, UITextFieldDelegate{
   

    
    @IBOutlet weak var personaladdressview_Height: NSLayoutConstraint!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var topBackgroundImage: UIImageView!
    
    @IBOutlet weak var profileImageView: UIView!
    @IBOutlet weak var profileImageButton: UIButton!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var name_Txt: UITextField!
    
    @IBOutlet weak var profileView: UIView!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var number_Txt: UITextField!
    
    @IBOutlet weak var myhamstechaddress_Lbl: UILabel!
    
    @IBOutlet weak var address_View: UIView!
    @IBOutlet weak var addresstextView_Txt: UITextView!
    @IBOutlet weak var editstart_Lbl: UILabel!
    
    var from = String()
    var imagePicker = UIImagePickerController()
       var marker1 = GMSMarker()
       var locationManager = CLLocationManager()
       var city = String()
       var address = String()
       var base64String = String()
       
       let data1 = Data1(location: CLLocation(latitude: 17.409634, longitude: 78.485407), area: "Himayatnagar", address1: "II, III & IV Floor, R.K. Plaza", address2: "HIMAYATNAGAR MAIN ROAD", city: "Hyderabad – 82 India", Phone: "PHONE: +91-7416066555", Email: "EMAIL: info@hamstech.com")

       let data2 = Data1(location: CLLocation(latitude: 17.436826, longitude: 78.453033), area: "Punjagutta", address1: "3RD FLOOR, OM TOWERS, OPPOSITE MCDONALD’S", address2: "Punjagutta ‘X’ Road", city: "HYDERABAD-29 India", Phone: "PHONE: +91-40-66684994, +91-40-66684995", Email: "EMAIL: info@hamstech.com")

       let data3 = Data1(location: CLLocation(latitude: 17.438766, longitude: 78.409774), area: "Jubilee Hills", address1: "Plot No 472, 2nd Floor, SAI Galleria", address2: "Above Nissan Showroom, Road No 36", city: "Hyderabad – 500033 India", Phone: "PHONE:+91-7207057291", Email: "EMAIL: info@hamstech.com")

       
       let data4 = Data1(location: CLLocation(latitude: 17.450836, longitude: 78.489081), area: "Secunderabad", address1: "II Floor, Jade Arcade", address2: "Paradise ‘X’ Road, M.G. Road", city: "Secunderabad – 03 India", Phone: "PHONE:+91-40-66484997, +91-40-66484998", Email: "EMAIL: info@hamstech.com")

       
       let data5 = Data1(location: CLLocation(latitude: 17.490768, longitude: 78.389206), area: "Kukatpally", address1: "3rd and 4th floor, above Neerus", address2: "Forum Mall circle JNTU road", city: "Hyderabad – 72 India", Phone: "PHONE:+91-04023155963", Email: "EMAIL: info@hamstech.com")

       
       let data6 = Data1(location: CLLocation(latitude: 17.442345, longitude: 78.369605), area: "Gachibowli", address1: "4th Floor, Vamsiram builders", address2: "Jyothi Imperial, Above South India Mall", city: "Hyderabad – 32 India", Phone: "PHONE:+91-7207599222", Email: "EMAIL: info@hamstech.com")
       
       let data7 = Data1(location: CLLocation(latitude: 17.370879, longitude: 78.543669), area: "Kothapet", address1: "4th Floor, Above More Mega Store", address2: "Beside Astalakshmi Temple Arch", city: "Hyderabad – 35 India", Phone: "PHONE:+91 40  2403 4994", Email: "EMAIL: info@hamstech.com")
       
    
    
    override func viewDidLoad() {
          super.viewDidLoad()

       
        
        
        ActivityServiceCalling(Pagename: "Profile", Activity: "Viewed")
          // Servicecall
        
        DispatchQueue.main.async {
            self.ProfileServiceCalling()
        }
          
          imagePicker.delegate = self
          
          self.scrollView.addSubview(contentView)
          self.scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 850)
      
          profileImageView.layer.cornerRadius = profileImageView.frame.size.height/2
          profileImageView.clipsToBounds = true
          
          profileImageButton.layer.cornerRadius = profileImageButton.frame.size.height/2
          profileImageButton.clipsToBounds = true
          
          profileImage.layer.cornerRadius = profileImage.frame.size.height/2
          profileImage.clipsToBounds = true

          // Nearest Location
          
          self.locationManager.delegate = self
          self.locationManager.startUpdatingLocation()

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

           currentLoc = CLLocation(latitude: 17.436826, longitude: 78.453033)
            

          } else {

          currentLoc = CLLocation(latitude: currentLoc.coordinate.latitude, longitude: currentLoc.coordinate.longitude)

          }

          // let userLocation = CLLocation(latitude: 17.4435, longitude: 78.3772)

          let closest = coordinates.min(by: { $0.distance(from: currentLoc) < $1.distance(from: currentLoc) })

              let lan = closest?.coordinate
                        
            let lat1 = lan?.latitude
            let lon1 = lan?.longitude

          let dataArray = [data1,data2,data3,data4,data5,data6,data7]

          for i in 0..<dataArray.count {
          let closerlocation = dataArray[i].location.coordinate
          let closerlat = closerlocation.latitude

          if closerlat == lat1! {

          myhamstechaddress_Lbl.text = "\(dataArray[i].address1), " + " \(dataArray[i].address2), " +  " \(dataArray[i].area), " + "\(dataArray[i].city),"  + " \(dataArray[i].Email),"  + " \(dataArray[i].Phone)."

       

      }
    }

        // getAddressFromLatLon(pdblLatitude: lan?.latitude ?? 0, withLongitude: lan?.longitude ?? 0)
     
          
      }
    
    override func viewWillAppear(_ animated: Bool) {
          self.navigationController?.navigationBar.isHidden = true
      }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    
    /// hamstech nearest Address
    
    
    
//        func getAddressFromLatLon(pdblLatitude: Double, withLongitude pdblLongitude: Double) {
//            var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
//
//            let lat: Double = pdblLatitude
//            //21.228124
//            let lon: Double = pdblLongitude
//            //72.833770
//            let ceo: CLGeocoder = CLGeocoder()
//            center.latitude = lat
//            center.longitude = lon
//
//            let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
//
//
//            ceo.reverseGeocodeLocation(loc, completionHandler:
//                {(placemarks, error) in
//                    if (error != nil)
//                    {
//                        print("reverse geodcode fail: \(error!.localizedDescription)")
//                    }
//                    let pm = placemarks! as [CLPlacemark]
//
//                    if pm.count > 0 {
//
//                        let pm = placemarks![0]
//
//                        var addressString : String = ""
//                        if pm.subLocality != nil {
//                            addressString = addressString + pm.subLocality! + ", "
//
//
//                        }
//                        if pm.thoroughfare != nil {
//                            addressString = addressString + pm.thoroughfare! + ", "
//                        }
//                        if pm.locality != nil {
//                            addressString = addressString + pm.locality! + ", "
//
//
//                        }
//                        if pm.country != nil {
//                            addressString = addressString + pm.country! + ", "
//
//
//                        }
//                        if pm.postalCode != nil {
//                            addressString = addressString + pm.postalCode! + " "
//
//
//
//                        }
//
//                        if pm.administrativeArea != nil {
//                            addressString = addressString + pm.postalCode! + " "
//
//
//
//                        }
//
//                        self.myhamstechaddress_Lbl.text  = addressString
//
//
//                  }
//            })
//
//        }
    
    
    
    
    
    
    @IBAction func profileImageButtonAction(_ sender: Any) {
    
        ActivityServiceCalling(Pagename: "Profile", Activity: "Imagechoose")
        
        let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.openCamera(UIImagePickerController.SourceType.camera)
        }
        let gallaryAction = UIAlertAction(title: "Gallery", style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.openGallery(UIImagePickerController.SourceType.photoLibrary)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
        }

        // Add the actions
        imagePicker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func editButtonAction(_ sender: Any) {
        
         ActivityServiceCalling(Pagename: "Profile", Activity: "Edit")
        
        name_Txt.isUserInteractionEnabled = true
        profileImageButton.isUserInteractionEnabled = true
        addresstextView_Txt.isUserInteractionEnabled = true
        editstart_Lbl.isHidden = false
        name_Txt.becomeFirstResponder()
        
        if addresstextView_Txt.text == "" || addresstextView_Txt.text == "Add Your Address" {
            
            
            self.personaladdressview_Height.constant = 125
            self.address_View.isHidden = false
                  
            
        }
        
       
    }
    
    @IBAction func backButtonAction(_ sender: Any)
    {
        
        if from == "notifi" {
            
          let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
           let tab = storyBoard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
           tab.selectedIndex = 0
           self.navigationController?.pushViewController(tab, animated: true)
            
            
        } else {
        
        _ = self.navigationController?.popViewController(animated: true)
        }}
    
    @IBAction func saveButtonAction(_ sender: Any) {
        
        editstart_Lbl.isHidden = true
      
        UpdateServiceCalling()
        
    }
    
    @IBAction func whatsAppAction(_ sender: Any) {
       
         ActivityServiceCalling(Pagename: "Profile", Activity: "Chat")
        
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
      
        ActivityServiceCalling(Pagename: "Profile", Activity: "Search")
        
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
    
    
//MARK:Open Camera and gallery
    
    func openCamera(_ sourceType: UIImagePickerController.SourceType) {
        
        if(UIImagePickerController.isSourceTypeAvailable(.camera) && UIImagePickerController.isSourceTypeAvailable(.photoLibrary))
        {
                imagePicker.sourceType = sourceType
                 self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
             let actionController: UIAlertController = UIAlertController(title: "Camera is not available",message: "", preferredStyle: .alert)
             let cancelAction: UIAlertAction = UIAlertAction(title: "OK", style: .cancel) { action -> Void  in
                        //Just dismiss the action sheet
             }
             actionController.addAction(cancelAction)
             self.present(actionController, animated: true, completion: nil)
        }
        
    }
    
    func openGallery(_ sourceType: UIImagePickerController.SourceType) {
        
        if(UIImagePickerController.isSourceTypeAvailable(.photoLibrary))
        {
                imagePicker.sourceType = sourceType
                 self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
                 let actionController: UIAlertController = UIAlertController(title: "Gallery is not available",message: "", preferredStyle: .alert)
                 let cancelAction: UIAlertAction = UIAlertAction(title: "OK", style: .cancel) { action -> Void  in
                            //Just dismiss the action sheet
                 }
                 actionController.addAction(cancelAction)
                 self.present(actionController, animated: true, completion: nil)
        }
        
    }

    //MARK:UIImagePickerControllerDelegate

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                                       
        guard let selectedImage = info[.originalImage] as? UIImage else {
        return

        }

        let cameraImage = selectedImage

        let orientationFixedImage = cameraImage.fixOrientation()

        profileImage.image = orientationFixedImage

        let imageData:Data = orientationFixedImage.pngData()!


       base64String = (imageData as Data).base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 1))

        DispatchQueue.main.async {
            
        self.editimageCalling()
            
        }
        dismiss(animated: true, completion: nil)
        
       

        }
//        profileImage.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
//        imagePicker.dismiss(animated: true, completion: nil)
//
//
//
//    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("imagePickerController cancel")
        dismiss(animated: true, completion: nil)
    }
    
    // Servicecall
    
    func ProfileServiceCalling() {

        if Reachability.isConnectedToNetwork(){

        let phonenumber: String = UserDefaults.standard.object(forKey: "phonenumber") as? String ?? ""

        let Urlname = "\(ConstantsKeys.AppLinks.BaseUrl)\(ConstantsKeys.AppGetUrls.getprofile)"

           // {"phone":"8056512411","page":"profile","apikey":"dsf99898398i3jofklese93"}
            
        let params  = ["phone": phonenumber, "apikey": ConstantsKeys.apikey.api_key,"page": "profile"]
           
           
           
       ActivityIndicatorWithLabel.shared.showProgressView(uiView: view)
            
        NetworkHelper.sharedInstance.postServiceCall(url: Urlname, PostDetails: params as [String : AnyObject]) { (response, error) in
            
      ActivityIndicatorWithLabel.shared.hideProgressView()
        
        let status = response["status"] as! NSDictionary
            
        let status1:Int =  Int(status["status"] as! Int)

            
        if status1 == 200{
     
        let loginResponseData = ProfileResponseModel (data: response["data"] as! NSDictionary)
  
            self.name_Txt.text = loginResponseData.prospectname ?? ""
            self.number_Txt.text = loginResponseData.phone ?? ""
            
            let image = loginResponseData.profilepic ?? ""

           // self.profileImage.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "profileImage"))
      
            
          // self.profileImage.setKFImage(with: image)
            DispatchQueue.main.async {
            if image == "" {
                
             self.profileImage.image = UIImage(named: "profileImage")
            } else {
            
//          self.profileImage.image = UIImage(url: URL(string:image))

            self.profileImage.sd_setImage(with: URL(string:image), placeholderImage: UIImage.init(named: "profileImage"), options: .highPriority, completed: { (img, imgerror, cachetype, imgur) in
                      })
                    //  }
                
            }
            }
            
            if loginResponseData.address == "" {
                
                
                self.addresstextView_Txt.delegate = self
                self.personaladdressview_Height.constant = 0
                self.address_View.isHidden = true
                self.addresstextView_Txt.text = "Add Your Address"
                self.addresstextView_Txt.textColor = UIColor.lightGray
                
            } else {
                
                self.addresstextView_Txt.text = loginResponseData.address ?? ""
                
            }
            
            let img = loginResponseData.profilepic ?? ""
            let number = loginResponseData.phone ?? ""
            let name = loginResponseData.prospectname ?? ""
  
            
            UserDefaults.standard.set(name, forKey: "prospectname")
            UserDefaults.standard.set(number, forKey: "phonenumber")
            UserDefaults.standard.set(img, forKey: "profilepic")
           
                      
        
            
        }else {
            
        
          self.view.window?.makeToast(response["message"] as? String, duration: 2.0, position: CSToastPositionCenter)
         }
        }
        }
        else
        {
        self.customPresentAlert(withTitle: "", message: "Please Check Network Connection")
        }
    }
 
    
      func UpdateServiceCalling() {

          if Reachability.isConnectedToNetwork(){
           

              let Urlname = "\(ConstantsKeys.AppLinks.BaseUrl)\(ConstantsKeys.AppGetUrls.updateprofile)"

             // {"phone":"8056512411","page":"profile","apikey":"dsf99898398i3jofklese93"}
            let params  = ["phone": number_Txt.text!,"appname":ConstantsKeys.apikey.appname,"page":"profile","apikey": ConstantsKeys.apikey.api_key,"email":"","prospectname":name_Txt.text!,"city":city,"address":addresstextView_Txt.text] as [String : Any]
          
        
            
        ActivityIndicatorWithLabel.shared.showProgressView(uiView: view)
            
          NetworkHelper.sharedInstance.postServiceCall(url: Urlname, PostDetails: params as [String : AnyObject]) { (response, error) in
            
          ActivityIndicatorWithLabel.shared.hideProgressView()
          
          let status = response["status"] as! NSDictionary
              
          let status1:Int =  Int(status["status"] as! Int)

              
          if status1 == 200{
              
            self.name_Txt.isUserInteractionEnabled = false
            self.profileImageButton.isUserInteractionEnabled = false
            self.addresstextView_Txt.isUserInteractionEnabled = false
            
            self.ProfileServiceCalling()
              
          }else {
              
          
            self.view.window?.makeToast(response["message"] as? String, duration: 2.0, position: CSToastPositionCenter)
           }
          }
          }
          else
          {
          self.customPresentAlert(withTitle: "", message: "Please Check Network Connection")
          }
      }
    
    
    
    func editimageCalling() {
        
    DispatchQueue.main.async {
        
        ActivityIndicatorWithLabel.shared.showProgressView(uiView: self.view)
        
        }
                if base64String == "" {

                    guard let selectedImage = profileImage.image else {
                           return

                    }

                  let cameraImage = selectedImage

                  let orientationFixedImage = cameraImage.fixOrientation()

                  profileImage.image = orientationFixedImage

                  let imageData:Data = orientationFixedImage.pngData()!


                  base64String = (imageData as Data).base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 1))

                 
        }

        let headers = [
          "content-type": "application/json",
          "cache-control": "no-cache",
          "postman-token": "04af07a7-54b3-439a-39c0-0db2c4bece99"
        ]
        
        let parameters = [
          "page": "profile",
          "phone": number_Txt.text!,
          "imagedata": base64String
        ] as [String : Any]

        let postData = try! JSONSerialization.data(withJSONObject: parameters, options: [])

        let request = NSMutableURLRequest(url: NSURL(string: "https://app.hamstech.com/qc/api/list/updateimage/")! as URL, cachePolicy: .useProtocolCachePolicy,timeoutInterval: 30.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
          if (error != nil) {
            
            
            print("error:",error!)
            
            DispatchQueue.main.async {
                  
              ActivityIndicatorWithLabel.shared.hideProgressView()
                
            }
            
       //  ActivityIndicatorWithLabel.shared.hideProgressView()
            
          } else {
            let httpResponse = response as? HTTPURLResponse
            
            DispatchQueue.main.async {
                 
             ActivityIndicatorWithLabel.shared.hideProgressView()
            }
            
            
            self.customPresentAlert(withTitle: "", message: "Profile Picture Updated Succesfully")
            
            print("httpResponse",httpResponse!)
            
            
    
          }
        })

        dataTask.resume()
        
        
        
    }
    
    
//    func editimageCalling(){
//
//              if Reachability.isConnectedToNetwork(){
//
//             let Urlname = "\(ConstantsKeys.AppLinks.BaseUrl)\(ConstantsKeys.AppGetUrls.updateimage)"
//
//              let params = ["page":"profile", "phone":number_Txt.text!]
//
//              ActivityIndicatorWithLabel.shared.showProgressView(uiView: view)
//
//                Alamofire.upload(multipartFormData: { multipartFormData in
//
//              //   DispatchQueue.main.async {
//              let imageData2 = (self.profileImage.image)?.jpegData(compressionQuality: 0.50)
//
//              multipartFormData.append(imageData2!, withName: "imagedata", fileName: "image.jpg", mimeType: "image/jpg")
//              //   }
//
//              for (key, value) in params {
//              multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
//              }
//              }, to: Urlname,
//
//              encodingCompletion: { encodingResult in
//              switch encodingResult {
//              case .success(let upload, _, _):
//              upload.responseJSON { response in
//
//              if let responseData = response.result.value as? [String : AnyObject]{
//
//             ActivityIndicatorWithLabel.shared.hideProgressView()
//
//                print("params:",params)
//
//                print(responseData)
//
//
//              let status = responseData["status"] as! NSDictionary
//
//                     let status1:Int =  Int(status["status"] as! Int)
//
//                     if status1 == 200{
//
//                     self.name_Txt.isUserInteractionEnabled = false
//                     self.profileImageButton.isUserInteractionEnabled = false
//                     self.addresstextView_Txt.isUserInteractionEnabled = false
//
//                     self.ProfileServiceCalling()
//
//                     }else {
//
//
//                     self.view.window?.makeToast(responseData["message"] as? String, duration: 2.0, position: CSToastPositionCenter)
//
//
//                     }
//              }
//              }
//              case .failure(let error):
//              print(error)
//              ActivityIndicatorWithLabel.shared.hideProgressView()
//              }
//
//              })
//              }
//              else{
//              self.customPresentAlert(withTitle: "", message: "Please Check Network Connection")
//              }
//          }
    
    

//        func editimageCalling(){
//
//            if base64String == "" {
//
//                guard let selectedImage = profileImage.image else {
//                       return
//
//                }
//
//              let cameraImage = selectedImage
//
//              let orientationFixedImage = cameraImage.fixOrientation()
//
//              profileImage.image = orientationFixedImage
//
//              let imageData:Data = orientationFixedImage.pngData()!
//
//
//              let base64String1 = (imageData as Data).base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 1))
//
//              base64String = base64String1.base64Encoded() ?? ""
//
//    }
//
//
//        if Reachability.isConnectedToNetwork(){
//
//           DispatchQueue.main.async {
//
//            ActivityIndicatorWithLabel.shared.showProgressView(uiView: self.view)
//
//            }
//
//        let Urlname = "\(ConstantsKeys.AppLinks.BaseUrl)\(ConstantsKeys.AppGetUrls.updateimage)"
//
//            let params = ["page":"profile", "phone":number_Txt.text!,"imagedata": base64String] as [String : Any]
//
//        NetworkHelper.sharedInstance.postServiceCall(url: Urlname, PostDetails: params as [String : AnyObject]) { (response, error) in
//
//        let status = response["status"] as! NSDictionary
//
//        let status1:Int =  Int(status["status"] as! Int)
//
//        if status1 == 200{
//
//        self.name_Txt.isUserInteractionEnabled = false
//        self.profileImageButton.isUserInteractionEnabled = false
//        self.addresstextView_Txt.isUserInteractionEnabled = false
//
//         self.ProfileServiceCalling()
//
//        }else {
//
//
//        self.view.window?.makeToast(response["message"] as? String, duration: 2.0, position: CSToastPositionCenter)
//
//
//        }
//        }
//
//         ActivityIndicatorWithLabel.shared.hideProgressView()
//
//
//        }
//        else
//        {
//        ActivityIndicatorWithLabel.shared.hideProgressView()
//        self.customPresentAlert(withTitle: "", message: "Please Check Network Connection")
//        }
//        }
  
    
   }


extension String {
    func toBase64() -> String? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }
        return data.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
    }
    
}


extension UIImage {
    func fixOrientation() -> UIImage {
        if self.imageOrientation == UIImage.Orientation.up {
            return self
        }
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        if let normalizedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return normalizedImage
        } else {
            return self
        }
    }
}

let otphash: String = UserDefaults.standard.object(forKey: "otphash") as? String ?? ""



