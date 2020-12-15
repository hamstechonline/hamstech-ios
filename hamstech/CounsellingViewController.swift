//
//  CounsellingViewController.swift
//  hamstech
//
//  Created by Priyanka on 15/05/20.
//

import UIKit
import YoutubePlayerView
import SideMenu

class CounsellingViewController: UIViewController, YoutubePlayerViewDelegate {

    @IBOutlet weak var back_But: UIButton!
    @IBOutlet weak var counsellingCollectionView: UICollectionView!
    
     var videoArray = ["VJMtR5t5rfg","VJMtR5t5rfg","VJMtR5t5rfg","VJMtR5t5rfg","VJMtR5t5rfg"]
    
    
        
        var Counclingdata = [CounclingResponseModel]()
        var fromsidemenu = Bool()
    
        override func viewDidLoad() {
            super.viewDidLoad()

            
             ActivityServiceCalling(Pagename: "Counselling", Activity: "Viewed")
            
            if fromsidemenu == true {
                   
                   back_But.isHidden = false
                   
               } else {
                   
                  back_But.isHidden = true
               }
            
            
            
        Counslingervicecalling()
            
    //       let playerVars: [String: Any] = [
    //                    "controls": 1,
    //                    "modestbranding": 1,
    //                    "playsinline": 1,
    //                    "autoplay": 1,
    //                    "origin": "https://youtube.com"
                   // ]
                  //  videoPlayer.delegate = self
                    //videoPlayer.loadWithVideoId("x-MBR13sVqs", with: playerVars)
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
        
    @IBAction func whatsAppAction(_ sender: Any) {
       
      ActivityServiceCalling(Pagename: "Counselling", Activity: "Chat")
        
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
      
        ActivityServiceCalling(Pagename: "Counselling", Activity: "Search")
        
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
    
    
    @IBAction func backButtonAction(_ sender: Any)
    {
        
       self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func callnow_Action(_ sender: Any) {
        
        ActivityServiceCalling(Pagename: "Counselling", Activity: "Call")
        
        if let phoneCallURL = URL(string: "tel://\(+9010100240)"), UIApplication.shared.canOpenURL(phoneCallURL)
        {
            UIApplication.shared.open(phoneCallURL, options: [:], completionHandler: nil)
        }
        
    }
    
    
    
     func Counslingervicecalling(){

            if Reachability.isConnectedToNetwork(){

                
            let Urlname = "\(ConstantsKeys.AppLinks.BaseUrl)\(ConstantsKeys.AppGetUrls.counseling_page)"

        let params  = ["metadata":["appname":"Hamstech","page":"hamstech_counseling_page","apikey":"dsf99898398i3jofklese93"]]
                  
                    
             //  ActivityIndicatorWithLabel.shared.showProgressView(uiView: view)
                 NetworkHelper.sharedInstance.postServiceCall(url: Urlname, PostDetails: params as [String : AnyObject]) { (response, error) in
               //  ActivityIndicatorWithLabel.shared.hideProgressView()
                     
                 let status:String =  String(response["status"] as! String)

                    if status == "ok"{

                        self.Counclingdata.removeAll()
                        if let dataArrya = response["counseling_details"] as? [[String: Any]] {
                        for list in dataArrya {
                        let object = CounclingResponseModel(data: list as NSDictionary)
                        self.Counclingdata.append(object)

                        }

                            self.counsellingCollectionView.reloadData()
                            
                        
                      }
                        
                    }else {
              
                   self.view.window?.makeToast(response["message"] as? String, duration: 2.0, position: CSToastPositionCenter)
                  }
             
                }
            } else
                 {
                 self.customPresentAlert(withTitle: "", message: "Please Check Network Connection")
            }

        }
        
        
        
        
        
        
        }
        
    extension CounsellingViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

            return Counclingdata.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {


                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! C_VideoCollectionViewCell
            
                      let playerVars: [String: Any] = [
                               "controls": 1,
                               "modestbranding": 1,
                              // "playsinline": 1,
                              // "autoplay": 1,
                               "origin": "https://youtube.com"
                           ]
            
                   cell.videoPlayer.delegate = self
            
                   let video = Counclingdata[indexPath.row].video_url!
            
                   cell.videoPlayer.loadWithVideoId(video, with: playerVars)
            
                   cell.councling_Lbl.text = Counclingdata[indexPath.row].counseling_name

                    cell.bgView.layer.cornerRadius = 15
                    cell.bgView.layer.borderWidth = 1.0
                    cell.bgView.layer.borderColor = UIColor.clear.cgColor
                    cell.bgView.layer.masksToBounds = true

                    return cell

                   }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
                 print("itm selected == \(indexPath.row)")
            }
        }
        
        

