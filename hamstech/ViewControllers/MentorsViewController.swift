//
//  MentorsViewController.swift
//  hamstech
//
//  Created by Priyanka on 07/05/20.
//

import UIKit
import YoutubePlayerView
import SideMenu

class MentorsViewController: UIViewController, YoutubePlayerViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var videoPlayer: YoutubePlayerView!
    @IBOutlet weak var bgMentorCollectionView: UIView!
    @IBOutlet weak var mentorsview_Height: NSLayoutConstraint!
    @IBOutlet weak var mentorstable: UITableView!
    
    var MentorsListingData = [MentorsdataResponseModel]()
    
    var selectedindex = Int()
    var selectedbool = Bool()
    
     override func viewDidLoad() {
     super.viewDidLoad()

        ActivityServiceCalling(Pagename: "Mentores", Activity: "Viewed")
       //servicecall
        MentorsServiceCalling()
        
//         // Video
//                let playerVars: [String: Any] = [
//                    "controls": 1,
//                    "modestbranding": 1,
//                    "playsinline": 1,
//                    "autoplay": 1,
//                    "origin": "https://youtube.com"
//                ]
//                videoPlayer.delegate = self
//                videoPlayer.loadWithVideoId("VJMtR5t5rfg", with: playerVars)
                
         }
    
    
//    override func viewWillLayoutSubviews() {
//    super.updateViewConstraints()
//
//
//    self.mentorsview_Height.constant = self.mentorstable.contentSize.height
//
//
//    }
    
    
     // YoutubePlayerView delegate methods
         func playerViewPreferredInitialLoadingView(_ playerView: YoutubePlayerView) -> UIView? {
                    let activityView = UIActivityIndicatorView(style: .gray)
                    activityView.center = self.view.center
                    activityView.startAnimating()
                   return activityView
                }
    
    
    @IBAction func whatsAppAction(_ sender: Any) {
       
        ActivityServiceCalling(Pagename: "Mentores", Activity: "Chat")
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
      
        ActivityServiceCalling(Pagename: "HomeViewController", Activity: "Search")
        
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
    
//    @IBAction func sidemenu_Action(_ sender: Any) {
//        present(SideMenuManager.default.menuRightNavigationController!, animated: true, completion: nil)
//    }
//
    // servicecall
    func MentorsServiceCalling() {

        if Reachability.isConnectedToNetwork(){

        //email,password,device_type,device_token

            let Urlname = "\(ConstantsKeys.AppLinks.BaseUrl)\(ConstantsKeys.AppGetUrls.mentors)"

            let params  = ["metadata": ["appname":ConstantsKeys.apikey.appname, "apikey": ConstantsKeys.apikey.api_key,"page": "mentors","lang":ConstantsKeys.apikey.lan] ] as [String : Any]

           
         ActivityIndicatorWithLabel.shared.showProgressView(uiView: view)
        NetworkHelper.sharedInstance.postServiceCall(url: Urlname, PostDetails: params as [String : AnyObject]) { (response, error) in
        ActivityIndicatorWithLabel.shared.hideProgressView()
            
        let status:String =  String(response["status"] as! String)

            
        if status == "ok"{
            
         
            if let mentors_video = response["mentors_video"] as? String {
                
             // Video
        let playerVars: [String: Any] = [
            "controls": 1,
            "modestbranding": 1,
            "playsinline": 1,
            "autoplay": 1,
            "origin": "https://youtube.com"
        ]
        self.videoPlayer.delegate = self
        self.videoPlayer.loadWithVideoId(mentors_video, with: playerVars)

                
            }
 
        self.MentorsListingData.removeAll()
        if let dataArrya = response["mentors_data"] as? [[String: Any]] {
        for list in dataArrya {
        let object = MentorsdataResponseModel(data: list as NSDictionary)
        self.MentorsListingData.append(object)
        }
            
        self.mentorstable.reloadData()
            
        self.mentorsview_Height.constant = CGFloat(self.MentorsListingData.count)*150+100
            
        }
           
            
            
            
        }else {
            
          self.MentorsListingData.removeAll()
            
          self.mentorstable.reloadData()
          self.view.window?.makeToast(response["message"] as? String, duration: 2.0, position: CSToastPositionCenter)
         }
        }
        }
        else
        {
        self.customPresentAlert(withTitle: "", message: "Please Check Network Connection")
        }
    }
    
    
    @IBAction func viewmore_Action(_ sender: UIButton) {
          
        selectedindex = sender.tag
        selectedbool = true
       
        mentorstable.reloadData()
        ActivityServiceCalling(Pagename: "Mentores", Activity: "Viewmore")
  
//          let story = UIStoryboard.init(name: "Main", bundle: nil)
//          let cartVC = story.instantiateViewController(withIdentifier: "MentoresPopupViewController") as! MentoresPopupViewController
//          cartVC.Title = MentorsListingData[sender.tag].mentors_title ?? ""
//          cartVC.Description = MentorsListingData[sender.tag].mentorss_description ?? ""
//          cartVC.img = MentorsListingData[sender.tag].mentor_image ?? ""
//          var viewcontroller = UIApplication.shared.keyWindow?.rootViewController
//          let navigation = UINavigationController.init(rootViewController: cartVC)
//          navigation.modalPresentationStyle = .overCurrentContext
//          while ((viewcontroller?.presentedViewController) != nil){
//          viewcontroller = viewcontroller?.presentedViewController
//          }
//          viewcontroller?.present(navigation, animated: false, completion: nil)
//
          
    
          
      }
    
    
    
}
         
     extension MentorsViewController: UITableViewDelegate, UITableViewDataSource {


        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return MentorsListingData.count
        }
        
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = mentorstable.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MentorScreentableviewcell
            
       

              cell.cornerRadiusView.layer.cornerRadius = 18
              cell.cornerRadiusView.layer.shadowColor = UIColor.lightGray.cgColor
              cell.cornerRadiusView.layer.shadowOpacity = 1
              cell.cornerRadiusView.layer.shadowOffset = CGSize.zero
              cell.cornerRadiusView.layer.shadowRadius = 5
               cell.viewmore_But.tag = indexPath.row
                    
                    cell.image_View.setKFImage(with: MentorsListingData[indexPath.row].mentor_image)
                    cell.description_Lbl.text = MentorsListingData[indexPath.row].mentorss_description
                    cell.title_Lbl.text = MentorsListingData[indexPath.row].mentors_title
                 
            if indexPath.row == selectedindex && selectedbool == true {
              
                cell.viewmore_But.isHidden = true
                
            } else {
                
                cell.viewmore_But.isHidden = false
                
            }
            
                 return cell

            }
   
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            
            if indexPath.row == selectedindex && selectedbool == true {
                
                return UITableView.automaticDimension
                
            } else {
              
                return 150
                
            }
           
        }
        

    
        
//
//        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//            self.viewWillLayoutSubviews()
//        }
        
         
     }


