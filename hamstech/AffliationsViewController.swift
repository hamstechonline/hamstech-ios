 //
//  AffliationsViewController.swift
//  hamstech
//
//  Created by Priyanka on 04/05/20.
//

import UIKit
import YoutubePlayerView
import SideMenu

class AffliationsViewController: UIViewController, YoutubePlayerViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var videoPlayer: YoutubePlayerView!
    @IBOutlet weak var bgCollectionView: UIView!
    @IBOutlet weak var affliationsCollectionView: UICollectionView!
    
    @IBOutlet weak var collection_Height: NSLayoutConstraint!
    var AfflicationListingData = [AfflicationdataResponseModel]()
    
    
    
    override func viewDidLoad() {
            super.viewDidLoad()

         ActivityServiceCalling(Pagename: "Afflication", Activity: "Viewed")
        
///////servicecalling///
        listingServiceCalling()
        
//            // Video
//            let playerVars: [String: Any] = [
//                "controls": 1,
//                "modestbranding": 1,
//                "playsinline": 1,
//                "autoplay": 1,
//                "origin": "https://youtube.com"
//            ]
//            videoPlayer.delegate = self
//
//            videoPlayer.loadWithVideoId("VJMtR5t5rfg", with: playerVars)
    }
    
    @IBAction func whatsAppAction(_ sender: Any) {
       
        ActivityServiceCalling(Pagename: "Afflication", Activity: "Chat")
        
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
    
    
    // YoutubePlayerView delegate methods
        func playerViewPreferredInitialLoadingView(_ playerView: YoutubePlayerView) -> UIView? {
            let activityView = UIActivityIndicatorView(style: .gray)
            activityView.center = self.view.center
            activityView.startAnimating()
           return activityView
            
        }
    
    
    ///////servicecalling///////
    
    func listingServiceCalling() {

        if Reachability.isConnectedToNetwork(){

        //email,password,device_type,device_token

            let Urlname = "\(ConstantsKeys.AppLinks.BaseUrl)\(ConstantsKeys.AppGetUrls.listaffliations)"

            let params  = ["metadata": ["appname":ConstantsKeys.apikey.appname, "apikey": ConstantsKeys.apikey.api_key,"page": "affliations","lang":ConstantsKeys.apikey.lan] ] as [String : Any]

           
            
        ActivityIndicatorWithLabel.shared.showProgressView(uiView: view)
        NetworkHelper.sharedInstance.postServiceCall(url: Urlname, PostDetails: params as [String : AnyObject]) { (response, error) in
        ActivityIndicatorWithLabel.shared.hideProgressView()
            
        let status:String =  String(response["status"] as! String)

            
        if status == "ok"{
            
            if let affliation_video = response["affliation_video"] as? String {

            // Video
            let playerVars: [String: Any] = [
            "controls": 1,
            "modestbranding": 1,
            "playsinline": 1,
            "autoplay": 1,
            "origin": "https://youtube.com"
            ]
            self.videoPlayer.delegate = self
            self.videoPlayer.loadWithVideoId(affliation_video, with: playerVars)


            }
            
            
            
        self.AfflicationListingData.removeAll()
        if let dataArrya = response["affliation_data"] as? [[String: Any]] {
        for list in dataArrya {
        let object = AfflicationdataResponseModel(data: list as NSDictionary)
        self.AfflicationListingData.append(object)
        }
            
        self.affliationsCollectionView.reloadData()
            self.collection_Height.constant = CGFloat(self.AfflicationListingData.count/2*200)
            
        }
            
        }else {
            
          self.AfflicationListingData.removeAll()
            
          self.affliationsCollectionView.reloadData()
          self.view.window?.makeToast(response["message"] as? String, duration: 2.0, position: CSToastPositionCenter)
         }
        }
        }
        else
        {
        self.customPresentAlert(withTitle: "", message: "Please Check Network Connection")
        }
    }
    
    

    @IBAction func backButtonAction(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    }
    extension AffliationsViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {


    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AfflicationListingData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
               
        
               let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! AffliationsCollectionViewCell
  
            cell.afflication_Img.setKFImage(with: AfflicationListingData[indexPath.row].affliation_image)
        
             
        
            cell.afflication_Lbl.text = AfflicationListingData[indexPath.row].affliations_descriptiom
        
         cell.afflication_Lbl.lineBreakMode = .byClipping
         // Use the outlet in our custom class to get a reference to the UILabel in the cell
            //cell.titleLabel.text = (self.array[indexPath.item] as! String)
            // cell.titleLabel.text = "Hello"
            // cell.backgroundColor = UIColor.cyan // make cell more visible in our example project
        return cell

    }
        
        
         func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        
              
            
              return CGSize(width: (CGFloat) (self.affliationsCollectionView.frame.size.width/2) ,height: 200)
              }
        
        
    }
