//
//  AboutUsViewController.swift
//  hamstech
//
//  Created by Priyanka on 27/05/20.
//

import UIKit
import YoutubePlayerView
import SideMenu

class AboutUsViewController: UIViewController,YoutubePlayerViewDelegate{


    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var contentView: UIView!

    @IBOutlet weak var videoPlayer: YoutubePlayerView!

    @IBOutlet weak var directorMessageView: UIView!

    @IBOutlet weak var directorsImage: UIImageView!

    @IBOutlet weak var directorsName: UILabel!

    @IBOutlet weak var directorsColorText: UILabel!

    @IBOutlet weak var directorsText: UILabel!
    @IBOutlet weak var ourHistoryView: UIView!

    @IBOutlet weak var HistoryText: UILabel!

    @IBOutlet weak var bgCollectionView: UIView!
    @IBOutlet weak var whyHamstechCollectionView: UICollectionView!


    @IBOutlet weak var whyhamstach_Height: NSLayoutConstraint!
    
    
      var from = String()
      var AboutUsListingData = [AboutUsDataResponseModel]()
        override func viewDidLoad() {
        super.viewDidLoad()

        ActivityServiceCalling(Pagename: "Aboutus", Activity: "Viewed")
            
        self.scrollView.addSubview(contentView)
        self.contentView.addSubview(videoPlayer)
        self.contentView.addSubview(directorMessageView)
        self.contentView.addSubview(ourHistoryView)
        self.contentView.addSubview(bgCollectionView)
        self.scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 3600)

        applyShadowOnView(directorMessageView)
        applyShadowOnView(ourHistoryView)

        self.aboutUsServiceCalling()

//        let playerVars: [String: Any] = [
//        "controls": 1,
//        "modestbranding": 1,
//        "playsinline": 1,
//        "autoplay": 1,
//        "origin": "https://youtube.com"
//        ]
//        videoPlayer.delegate = self
//        videoPlayer.loadWithVideoId("VJMtR5t5rfg", with: playerVars)
            
            
        //  let strYoutubeKey = extractYoutubeIdFromLink(link: strVideoUrl)
        //  if(strYoutubeKey != nil){
        //  playerView.load(withVideoId:"84lmw1sFpHw", playerVars: playerVars)
        // playerView.loadWithVideoId(strYoutubeKey!, with: playerVars)
        }

    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
        // YoutubePlayerView delegate methods
        func playerViewPreferredInitialLoadingView(_ playerView: YoutubePlayerView) -> UIView? {
        let activityView = UIActivityIndicatorView(style: .gray)
        activityView.center = self.view.center
        activityView.startAnimating()
        return activityView

        }

        //            // Applying shadow on UIViews
        //            func applyShadowOnView(_ view:UIView) {
        //
        //                    view.layer.cornerRadius = 8
        //                    view.layer.shadowColor = UIColor.lightGray.cgColor
        //                    view.layer.shadowOpacity = 1
        //                    view.layer.shadowOffset = CGSize.zero
        //                    view.layer.shadowRadius = 5
        //
        //            }


        @IBAction func whatsAppAction(_ sender: Any) {
           
        ActivityServiceCalling(Pagename: "Aboutus", Activity: "Chat")
            
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
          
            ActivityServiceCalling(Pagename: "Aboutus", Activity: "Search")
            
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
            
            if from == "notifi" {
               
            let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
            let tab = storyBoard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
            tab.selectedIndex = 0
            self.navigationController?.pushViewController(tab, animated: true)
                
            } else {
            
        _ = self.navigationController?.popViewController(animated: true)
            }
        }

        //# Mark: service call

        func aboutUsServiceCalling() {

        if Reachability.isConnectedToNetwork(){


        let Urlname = "\(ConstantsKeys.AppLinks.BaseUrl)\(ConstantsKeys.AppGetUrls.aboutus)"

        let params  = ["metadata": ["appname":"Hamstech", "apikey": ConstantsKeys.apikey.api_key,"page": "aboutus","lang":ConstantsKeys.apikey.lan] ] as [String : Any]

           
            
        ActivityIndicatorWithLabel.shared.showProgressView(uiView: view)

        NetworkHelper.sharedInstance.postServiceCall(url: Urlname, PostDetails: params as [String : AnyObject]) { (response, error) in

        ActivityIndicatorWithLabel.shared.hideProgressView()

        let status:String =  String(response["status"] as! String)


        if status == "ok"{
            
            if let aboutus_video = response["aboutus_video"] as? String {
                               
                            // Video
                       let playerVars: [String: Any] = [
                           "controls": 1,
                           "modestbranding": 1,
                           "playsinline": 1,
                           "autoplay": 1,
                           "origin": "https://youtube.com"
                       ]
                       self.videoPlayer.delegate = self
                       self.videoPlayer.loadWithVideoId(aboutus_video, with: playerVars)

                               
        }
                           
       self.AboutUsListingData.removeAll()

        // let video:String = String(response["aboutus_video"] as! String)
//String(response["ajitha_yogesh_text"] as! String)
           
         let name =  String(response["director_name"] as! String)
            
            self.directorsName.text = name
            
        let Image:String = String(response["ajitha_image"] as! String)
        self.directorsImage.image = UIImage.init(url: URL.init(string: Image))
        let coloredText:String = String(response["ajitha_yogesh_colored_text"] as! String)
        self.directorsColorText.text = coloredText
        let text:String = String(response["ajitha_yogesh_text"] as! String)
        self.directorsText.text = text

        let history:String = String(response["our_history"] as! String)
        self.HistoryText.text = history

        if let dataArrya = response["why_hamstech_images"] as? [[String: Any]] {
        for list in dataArrya {

        let object = AboutUsDataResponseModel(data: list as NSDictionary)
        self.AboutUsListingData.append(object)
        }
            
            self.whyhamstach_Height.constant = CGFloat(self.AboutUsListingData.count/2*220)+66
        self.whyHamstechCollectionView.reloadData()
            
            
        }
        }else {

        self.AboutUsListingData.removeAll()

        self.whyHamstechCollectionView.reloadData()
        self.view.window?.makeToast(response["message"] as? String, duration: 2.0, position: CSToastPositionCenter)
        }
        }
        }
        else
        {
        self.customPresentAlert(withTitle: "", message: "Please Check Network Connection")
        }
        }






        }

        extension AboutUsViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {


        if collectionView == whyHamstechCollectionView {

            return AboutUsListingData.count
        } else {

        return 0
        }


        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {


        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! AboutUs_WhyHamstechCollectionViewCell
            
            cell.back_View.layer.cornerRadius = 25
                           cell.back_View.layer.borderWidth = 1.0
                           cell.back_View.layer.borderColor = UIColor.clear.cgColor
                           cell.back_View.layer.masksToBounds = true
                           
            cell.hamstach_Img.setKFImage(with: AboutUsListingData[indexPath.row].upload_images)
            
            

        //                cell.hamstechCellView.layer.cornerRadius = 25
        //                cell.hamstechCellView.layer.borderWidth = 1.0
        //                cell.hamstechCellView.layer.borderColor = UIColor.clear.cgColor
        //                cell.hamstechCellView.layer.masksToBounds = true
        //
        //                cell.hamstechCellImg.image = UIImage(named: h[indexPath.row])

       // if indexPath.row == 2 {

        //                    cell.leading.constant = whyHamstechCollectionView.frame.size.width/4
        //                    cell.trailing.constant = whyHamstechCollectionView.frame.size.width/4

      //  } else {

        //                   cell.leading.constant = 10
        //                   cell.trailing.constant = 10

       // }

        return cell

        }


        func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {


        //  if collectionView == whyHamstechCollectionView {




        return CGSize(width: (CGFloat) (self.whyHamstechCollectionView.frame.size.width/2) ,height: (CGFloat) (218))


        }




                func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                if collectionView == self.whyHamstechCollectionView
                {
                print("itm selected == \(indexPath.row)")
                }
                }


         override func didReceiveMemoryWarning() {
                 super.didReceiveMemoryWarning()
                 // Dispose of any resources that can be recreated.
             }
         }
