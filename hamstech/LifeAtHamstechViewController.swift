//
//  LifeAtHamstechViewController.swift
//  hamstech
//
//  Created by Priyanka on 15/05/20.
//

import UIKit
import YoutubePlayerView
import GoogleMaps
import GooglePlaces
import CoreLocation
import MapKit
import SideMenu

class LifeAtHamstechViewController: UIViewController, YoutubePlayerViewDelegate, GMSMapViewDelegate,CLLocationManagerDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var videoPlayer: YoutubePlayerView!
    
    @IBOutlet weak var bgGalleryView: UIView!
    
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    
    @IBOutlet weak var bgEventsView: UIView!
    
    @IBOutlet weak var eventsCollectionView: UICollectionView!
    
    @IBOutlet weak var bgCampusView: UIView!
    
    @IBOutlet weak var campous_Map: GMSMapView!
    @IBOutlet weak var events_Height: NSLayoutConstraint!
    
    @IBOutlet weak var more_But: UIButton!
    var markers = [GMSMarker]()
    var locationManager = CLLocationManager()

    
    var dataArray = [Data1]()
    
    var lifeAtHamstechGalleryData = [LifeAtHamstechgalleryResponseModel]()
    var lifeAtHamstechEventsData =  [LifeAtHamstecheventsResponseModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       ActivityServiceCalling(Pagename: "LifeatHamstach", Activity: "Viewed")
        
        campous_Map.delegate = self
        
        locations()
        
        self.lifeAtHamstechServiceCalling()
        
            self.scrollView.addSubview(contentView)
            self.contentView.addSubview(videoPlayer)
            self.contentView.addSubview(videoPlayer)
            self.contentView.addSubview(bgGalleryView)
            self.contentView.addSubview(bgEventsView)
           self.contentView.addSubview(bgCampusView)
            self.scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 3000)

             
        
            
//            let playerVars: [String: Any] = [
//                    "controls": 1,
//                    "modestbranding": 1,
//                    "playsinline": 1,
//                    "autoplay": 1,
//                    "origin": "https://youtube.com"
//                ]
//                videoPlayer.delegate = self
//                videoPlayer.loadWithVideoId("VJMtR5t5rfg", with: playerVars)
              //  let strYoutubeKey = extractYoutubeIdFromLink(link: strVideoUrl)
              //  if(strYoutubeKey != nil){
                  //  playerView.load(withVideoId:"84lmw1sFpHw", playerVars: playerVars)
                   // playerView.loadWithVideoId(strYoutubeKey!, with: playerVars)
                }
            
        // YoutubePlayerView delegate methods
        func playerViewPreferredInitialLoadingView(_ playerView: YoutubePlayerView) -> UIView? {
            let activityView = UIActivityIndicatorView(style: .gray)
            activityView.center = self.view.center
            activityView.startAnimating()
           return activityView
            
        }
    

    
      func branches(){
    
          let marker = GMSMarker()
          
          for i in dataArray {
            
            let location = i.location
            
            let lat: CLLocationDegrees =  location.coordinate.latitude
            let lon: CLLocationDegrees = location.coordinate.longitude
              
              marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            
              marker.map = campous_Map
              campous_Map.isMyLocationEnabled = true
      
              campous_Map.delegate = self
            
 
             // campous_Map.settings.scrollGestures = false
              campous_Map.camera = GMSCameraPosition.camera(withTarget: marker.position, zoom: 11)
            
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
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        
        if(mapView.camera.zoom <= 11) {
         
            campous_Map.settings.scrollGestures = false
           
            
        } else {
            
            campous_Map.settings.scrollGestures = true
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
    
    
    @IBAction func whatsAppAction(_ sender: Any) {
       
        ActivityServiceCalling(Pagename: "LifeatHamstach", Activity: "Chat")
        
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
      
        ActivityServiceCalling(Pagename: "LifeatHamstach", Activity: "Search")
        
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
    
    @IBAction func backButtonAction(_ sender: Any) {
          _ = self.navigationController?.popViewController(animated: true)
    }
    
    // servicecall
      func lifeAtHamstechServiceCalling() {

          if Reachability.isConnectedToNetwork(){

          //email,password,device_type,device_token

              let Urlname = "\(ConstantsKeys.AppLinks.BaseUrl)\(ConstantsKeys.AppGetUrls.lifeAtHamstech)"

              let params  = ["metadata": ["appname":"Hamstech", "apikey": "dsf99898398i3jofklese93","page": "life_at_hamstech","lang":"en"] ] as [String : Any]

         
            
         ActivityIndicatorWithLabel.shared.showProgressView(uiView: view)
          NetworkHelper.sharedInstance.postServiceCall(url: Urlname, PostDetails: params as [String : AnyObject]) { (response, error) in
           ActivityIndicatorWithLabel.shared.hideProgressView()
                                
              
          let status:String =  String(response["status"] as! String)

              
          if status == "ok"{
              
            if let hamstech_videos = response["hamstech_videos"] as? String {

                       // Video
                       let playerVars: [String: Any] = [
                       "controls": 1,
                       "modestbranding": 1,
                       "playsinline": 1,
                       "autoplay": 1,
                       "origin": "https://youtube.com"
                       ]
                       self.videoPlayer.delegate = self
                       self.videoPlayer.loadWithVideoId(hamstech_videos, with: playerVars)


                       }
            
            
            
          self.lifeAtHamstechGalleryData.removeAll()
          self.lifeAtHamstechEventsData.removeAll()
            
          if let dataArrya = response["hamstech_gallery"] as? [[String: Any]] {
            
          for list in dataArrya {
          let object = LifeAtHamstechgalleryResponseModel(data: list as NSDictionary)
          self.lifeAtHamstechGalleryData.append(object)
          }
            
          self.galleryCollectionView.reloadData()
          }
            
          if let eventDataArrya = response["hamstech_events"] as? [[String: Any]] {
            
          for list in eventDataArrya {
          let eventObject = LifeAtHamstecheventsResponseModel(data: list as NSDictionary)
          self.lifeAtHamstechEventsData.append(eventObject)
          }
            
          self.eventsCollectionView.reloadData()
            
       // self.events_Height.constant = CGFloat(self.lifeAtHamstechEventsData.count/2) * 190 + 65
            
            
            print("self.lifeAtHamstechEventsData.count", self.lifeAtHamstechEventsData.count)
            
            self.events_Height.constant = 495
         
            if self.lifeAtHamstechEventsData.count > 4 {
                
                self.more_But.isHidden = false
                
            } else {
               
                self.more_But.isHidden = true
            }
            
            
            
          }
        }else {
              
            self.lifeAtHamstechGalleryData.removeAll()
            self.lifeAtHamstechEventsData.removeAll()
              
            self.galleryCollectionView.reloadData()
            self.eventsCollectionView.reloadData()
            self.view.window?.makeToast(response["message"] as? String, duration: 2.0, position: CSToastPositionCenter)
           }
          }
          }
          else
          {
          self.customPresentAlert(withTitle: "", message: "Please Check Network Connection")
          }
      }
      
      
    @IBAction func moreevent_Action(_ sender: Any) {
        
        self.events_Height.constant = CGFloat(self.lifeAtHamstechEventsData.count/2) * 190 + 115
        
      }
    
    }

    
    

extension LifeAtHamstechViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == galleryCollectionView {
        return lifeAtHamstechGalleryData.count
        } else {
            return lifeAtHamstechEventsData.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
               
     if collectionView == galleryCollectionView {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! LAH_GalleryCollectionViewCell

        cell.bgGalleryView.layer.cornerRadius = 5.0
        cell.bgGalleryView.layer.borderWidth = 1.0
        cell.bgGalleryView.layer.borderColor = UIColor.clear.cgColor
        cell.bgGalleryView.layer.masksToBounds = true

        cell.layer.shadowColor = UIColor.lightGray.cgColor;
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0);
        cell.layer.shadowRadius = 2.0;
        cell.layer.shadowOpacity = 35;
        cell.layer.masksToBounds = false;
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath;


       cell.galleryImages.setKFImage(with: lifeAtHamstechGalleryData[indexPath.row].LifeAtHamstech_image)
        
        return cell

    } else  {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! LAH_EventsCollectionViewCell
        
        cell.eventTitle.text = lifeAtHamstechEventsData[indexPath.row].LifeAtHamstech_title
        cell.eventImages.setKFImage(with: lifeAtHamstechEventsData[indexPath.row].LifeAtHamstech_addimage)

    return cell

        }
}
  
    

    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        
             print("itm selected == \(indexPath.row)")
        
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        
        
        return CGSize(width: (CGFloat) (self.eventsCollectionView.frame.size.width/2) ,height: (CGFloat) (190))
    }
    
    
        
}

