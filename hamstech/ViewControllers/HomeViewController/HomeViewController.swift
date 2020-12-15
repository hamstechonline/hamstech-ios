//
//  HomeViewController.swift
//  hamstech
//
//  Created by Priyanka on 30/04/20.
//

import UIKit
import SideMenu
import YoutubePlayerView

class HomeViewController: UIViewController, UIAlertViewDelegate, YoutubePlayerViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var courseView: UIView!
    @IBOutlet weak var mentorView: UIView!
    @IBOutlet weak var whyHamstechView: UIView!
    @IBOutlet weak var placementsView: UIView!
    @IBOutlet weak var affliationsView: UIView!
    @IBOutlet weak var testimonialsView: UIView!
    
    
    @IBOutlet weak var bannersCollectionView: UICollectionView!
    @IBOutlet weak var courseCollectionView: UICollectionView!
    @IBOutlet weak var mentorCollectionView: UICollectionView!
    @IBOutlet weak var whyHamstechCollectionView: UICollectionView!
    @IBOutlet weak var placementsCollectionView: UICollectionView!
    @IBOutlet weak var affliationsCollectionView: UICollectionView!
    @IBOutlet weak var testimonialsCollectionView: UICollectionView!
    @IBOutlet weak var bannerpagecontroler: UIPageControl!
    @IBOutlet weak var affliationspagecontroller: UIPageControl!
    @IBOutlet weak var courses_Height: NSLayoutConstraint!
  //  @IBOutlet weak var mainview_Height: NSLayoutConstraint!
    @IBOutlet weak var hamstechview_Height: NSLayoutConstraint!
    @IBOutlet weak var videoPlayer: YoutubePlayerView!
    
    @IBOutlet weak var onlinelearning_Lbl: UILabel!
    @IBOutlet weak var mentors_Lbl: UILabel!
    @IBOutlet weak var placement_Lbl: UILabel!
    @IBOutlet weak var afflication_Lbl: UILabel!
    @IBOutlet weak var testinominal_Lbl: UILabel!
    
    
    static var currentPage: Int = 0
   // static var currentPage1: Int = 0
   
    var timer:Timer!
    var timer2:Timer!
    var yOffset: CGFloat = 0
    var from = String()
    
//    var cources = ["c1","c2","c3","c4","c5","c6","c7"]
//    //var h = ["h1","h2","h3","h4","h5"]
//     var m = ["mentors","mentors1","mentors2","mentors3"]
//    var p = ["placement1","placement2","placement3","placement4","placement5","placement6"]
//
//    var h = ["Fashion Design","Interior Design","Photography","Fashion Styling","Jewellery Design","Graphic Design","Baking"]
    
    
    var homePageSliderData =  [homePageSliderDataResponseModel]()
    var courseDetailsData  =  [courseDetailsDataResponseModel]()
    var mentorsDetailsData =  [mentorsDetailsDataResponseModel]()
    var whyHamstechData    =  [whyHamstechDataResponseModel]()
    var placementsData     =  [placementsDataResponseModel]()
    var affliationsData    =  [affliationsDataResponseModel]()
    var testimonialsData   =  [testimonialsDataResponseModel]()
     
    var Scrollinftimer = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        applyShadowOnView(videoPlayer)
        // Force Update
        var forceUpdate = self.needsUpdate()
        print("forceUpdate = \(forceUpdate)")
        
    
        
        ActivityServiceCalling(Pagename: "HomeViewController", Activity: "Homeviewed")
        
        self.homeServiceCalling()

        let floawLayout = UPCarouselFlowLayout()
        floawLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 60.0, height: testimonialsCollectionView.frame.size.height)
        floawLayout.scrollDirection = .horizontal
        floawLayout.sideItemScale = 0.8
        floawLayout.sideItemAlpha = 1.0
        floawLayout.spacingMode = .fixed(spacing: 5.0)
        testimonialsCollectionView.collectionViewLayout = floawLayout
        
        
       /////////////// sidemenu////////////////
        
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        SideMenuManager.default.menuAnimationDismissDuration = 0.2
        SideMenuManager.default.menuAnimationPresentDuration = 0.5
        SideMenuManager.default.menuFadeStatusBar = false
        SideMenuManager.default.menuShadowRadius = 50
        SideMenuManager.default.menuShadowOpacity = 1
        
        let menuVC = self.storyboard?.instantiateViewController(withIdentifier: "SidemenuViewController")
        
        let menuLeftNavigationController = UISideMenuNavigationController(rootViewController: menuVC!)
        menuLeftNavigationController.leftSide = false
        
        SideMenuManager.default.menuRightNavigationController = menuLeftNavigationController
        
        let tabbar: String = UserDefaults.standard.object(forKey: "tabbar") as? String ?? ""
        
        if tabbar == "tab" {
       
             UserDefaults.standard.removeObject(forKey: "tabbar")
            
            timer2 = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: false)
        
        }
        
    }
    
    
    
    
        
    

    @objc func timerAction() {

       // self.tabBarController?.selectedIndex = 1
        
        yOffset += 200

        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.1) {
                self.scrollView.contentOffset.y = self.yOffset
            }
        }
    }
  
    
    
   override func viewWillAppear(_ animated: Bool) {
    
           self.navigationController?.navigationBar.isHidden = true
    
  }
    
    
    
    
    func playerViewPreferredInitialLoadingView(_ playerView: YoutubePlayerView) -> UIView? {
          let activityView = UIActivityIndicatorView(style: .gray)
          activityView.center = self.view.center
          activityView.startAnimating()
         return activityView
          
      }
    
    
    @objc func autoScrollImageSlider() {

        DispatchQueue.main.async {

        let visibleItems = self.bannersCollectionView.indexPathsForVisibleItems

        if visibleItems.count > 0 {

        let currentItemIndex: IndexPath? = visibleItems[0]

            if currentItemIndex?.item == self.homePageSliderData.count - 1 {
        let nexItem = IndexPath(item: 0, section: 0)

        self.bannersCollectionView.scrollToItem(at: nexItem, at: .centeredHorizontally, animated: true)

        } else {

        let nexItem = IndexPath(item: (currentItemIndex?.item ?? 0) + 1, section: 0)

        self.bannersCollectionView.scrollToItem(at: nexItem, at: .centeredHorizontally, animated: true)
        }
        }
        }

        DispatchQueue.main.async {

        let visibleItems = self.affliationsCollectionView.indexPathsForVisibleItems

           
            
        if visibleItems.count > 0 {

        let currentItemIndex: IndexPath? = visibleItems[0]

        if currentItemIndex?.item == self.affliationsData.count - 1 {
        let nexItem = IndexPath(item: 0, section: 0)

        self.affliationsCollectionView.scrollToItem(at: nexItem, at: .centeredHorizontally, animated: true)

        } else {

        let nexItem = IndexPath(item: (currentItemIndex?.item ?? 0) + 1, section: 0)

        self.affliationsCollectionView.scrollToItem(at: nexItem, at: .centeredHorizontally, animated: true)
        }
        }
        }
        
      }
    
    
    @objc func autoScrollImageSlider1() {
        
//        if let indexPath = testimonialsCollectionView.indexPathsForVisibleItems.first
//        {
//            let indexPath = IndexPath(row: self.indexPath + 1, section: 0)
//
//                       self.testimonialsCollectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
//        }
//        else {
//            return
//        }
        
        
//        let visibleItems = self.testimonialsCollectionView.indexPathsForVisibleItems
////
////     //  let indexPath = testimonialsCollectionView.indexPath(for: TestimonialsCollectionViewCell)
////
////               if visibleItems.count > 0 {
////
////               let currentItemIndex: IndexPath? = visibleItems[0]
////
////        let indexPath = IndexPath(item: (currentItemIndex?.item ?? -1) + 1, section: 0)
//
//
//                if index == -1 {
//                    timer.invalidate()
//                }
//
//                index += 1
//                let indexPath = IndexPath(row: index, section: 0)
//
//    testimonialsCollectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
//
        
        
//        DispatchQueue.main.async {
//
//            let visibleItems = self.testimonialsCollectionView.indexPathsForVisibleItems.first
//
//            print("visibleItems = \(visibleItems)")
//
//
//            if visibleItems!.count > 0 {
//
//            let currentItemIndex: IndexPath? = visibleItems
//
//        if currentItemIndex?.item == self.testimonialsData.count - 1 {
//        let nexItem = IndexPath(item: 0, section: 0)
//
//        self.testimonialsCollectionView.scrollToItem(at: nexItem, at: .centeredHorizontally, animated: true)
//
//        } else {
//
////            if self.index == -1 {
////            self.timer.invalidate()
////            }
//
//
//             let nexItem = IndexPath(item: (currentItemIndex?.item ?? 0) + 1, section: 0)
//
//             self.testimonialsCollectionView.scrollToItem(at: nexItem, at:UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
//
//            // self.index += 1
//        }
//        }
//        }
//        }
        
        
                
        
        
        
    
        
        
        
    
        /*
                DispatchQueue.main.async {

                let visibleItems = self.testimonialsCollectionView.indexPathsForVisibleItems
                    
                print("visibleItems", visibleItems.count)

                    
                if visibleItems.count == 2 {

                let currentItemIndex: IndexPath? = visibleItems[1]

                if currentItemIndex?.item == self.testimonialsData.count - 1 {

                let nexItem = IndexPath(item: 0, section: 0)

                    
                    self.testimonialsCollectionView.scrollToItem(at: nexItem, at: .centeredHorizontally, animated: true)
                 
                } else {

                    
                    
                let nexItem = IndexPath(item: (currentItemIndex?.item ?? 0) + 1, section: 0)
                    
                    print("nexItem",nexItem)
                    
   
                self.testimonialsCollectionView.scrollToItem(at: nexItem, at: .centeredHorizontally, animated: true)
              }
                } else if visibleItems.count == 3 {

                let currentItemIndex: IndexPath? = visibleItems[2]
              //  let currentItemIndex1: IndexPath? = visibleItems[1]
                    
                if currentItemIndex?.item == self.testimonialsData.count - 1 {

                let nexItem = IndexPath(item: (currentItemIndex?.item ?? 0) + 1, section: 0)
           
                self.testimonialsCollectionView.scrollToItem(at: nexItem, at: .centeredHorizontally, animated: true)

                   }else {

                let currentItemIndex1: IndexPath? = visibleItems[2]
                    
               let nexItem = IndexPath(item: (currentItemIndex1?.item ?? 0 + 1) , section: 0)
              
                     print("nexItem",nexItem)
                    
                self.testimonialsCollectionView.scrollToItem(at: nexItem, at: .centeredHorizontally, animated: true)
                    
                 }
                } else if visibleItems.count == 4 {

                     let currentItemIndex: IndexPath? = visibleItems[3]
                   //  let currentItemIndex1: IndexPath? = visibleItems[1]
                         
                     if currentItemIndex?.item == self.testimonialsData.count - 1 {

                     let nexItem = IndexPath(item: (currentItemIndex?.item ?? 0) + 1, section: 0)
                
                     self.testimonialsCollectionView.scrollToItem(at: nexItem, at: .centeredHorizontally, animated: true)

                        }else {

                     let currentItemIndex1: IndexPath? = visibleItems[3]
                         
                    let nexItem = IndexPath(item: (currentItemIndex1?.item ?? 0 + 1) , section: 0)
                   
                          print("nexItem",nexItem)
                         
                     self.testimonialsCollectionView.scrollToItem(at: nexItem, at: .centeredHorizontally, animated: true)
                         
                      }
                     }
                    
                    
                }
        */
    }
    
    
   
    
    
    @IBAction func whatsAppAction(_ sender: Any) {
       
        
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
    
    func moveToFrame(contentOffset : CGFloat) {
        
        let frame: CGRect = CGRect(x : contentOffset ,y : self.bannersCollectionView.contentOffset.y ,width : self.bannersCollectionView.frame.width,height : self.bannersCollectionView.frame.height)
        self.bannersCollectionView.scrollRectToVisible(frame, animated: true)
    }
    
    func moveToFrame1(contentOffset : CGFloat) {
        
        let frame: CGRect = CGRect(x : contentOffset ,y : self.affliationsCollectionView.contentOffset.y ,width : self.affliationsCollectionView.frame.width,height : self.affliationsCollectionView.frame.height)
        self.affliationsCollectionView.scrollRectToVisible(frame, animated: true)
    }
    
    func moveToFrame2(contentOffset : CGFloat) {
        
        let frame: CGRect = CGRect(x : contentOffset ,y : self.testimonialsCollectionView.contentOffset.y ,width : self.testimonialsCollectionView.frame.width,height : self.testimonialsCollectionView.frame.height)
        self.testimonialsCollectionView.scrollRectToVisible(frame, animated: true)
    }
    
    
    
    @IBAction func bannerprevious_Action(_ sender: Any) {
          
          
       let collectionBounds = self.bannersCollectionView.bounds
    
          var contentOffset: CGFloat = 0

          contentOffset = CGFloat(floor(self.bannersCollectionView.contentOffset.x - collectionBounds.size.width))
          HomeViewController.currentPage += HomeViewController.currentPage <= 0 ? 0 : 1
             self.moveToFrame(contentOffset: contentOffset+1)

      }
    
    @IBAction func bannernext_Action(_ sender: Any) {
        
        let collectionBounds = self.bannersCollectionView.bounds

        var contentOffset: CGFloat = 0

        contentOffset = CGFloat(floor(self.bannersCollectionView.contentOffset.x + collectionBounds.size.width))
        HomeViewController.currentPage -= HomeViewController.currentPage <= 0 ? 0 : 1
        self.moveToFrame(contentOffset: contentOffset-1)
        
    }
    
    @IBAction func afflicationprevious_Action(_ sender: Any) {
        
        let collectionBounds = self.affliationsCollectionView.bounds

        var contentOffset: CGFloat = 0

        contentOffset = CGFloat(floor(self.affliationsCollectionView.contentOffset.x - collectionBounds.size.width))
        HomeViewController.currentPage += HomeViewController.currentPage <= 0 ? 0 : 1
        self.moveToFrame1(contentOffset: contentOffset+1)
        
    }
    
    @IBAction func afflicationnext_Action(_ sender: Any) {
        
        let collectionBounds = self.affliationsCollectionView.bounds

        var contentOffset: CGFloat = 0

        contentOffset = CGFloat(floor(self.affliationsCollectionView.contentOffset.x + collectionBounds.size.width))
        HomeViewController.currentPage -= HomeViewController.currentPage <= 0 ? 0 : 1
        self.moveToFrame1(contentOffset: contentOffset-1)


    }
    
    // servicecall
         func homeServiceCalling() {

             if Reachability.isConnectedToNetwork(){

            
                 let Urlname = "\(ConstantsKeys.AppLinks.BaseUrl)\(ConstantsKeys.AppGetUrls.home)"

                 let params  = ["metadata": ["appname":"Hamstech", "apikey": "dsf99898398i3jofklese93","page": "hamstech_home_page","lang":"en"] ] as [String : Any]

                
            ActivityIndicatorWithLabel.shared.showProgressView(uiView: view)
             NetworkHelper.sharedInstance.postServiceCall(url: Urlname, PostDetails: params as [String : AnyObject]) { (response, error) in
             ActivityIndicatorWithLabel.shared.hideProgressView()
                 
             let status:String =  String(response["status"] as! String)

             if status == "ok"{
                 
             self.homePageSliderData.removeAll()
             self.courseDetailsData.removeAll()
             self.mentorsDetailsData.removeAll()
             self.whyHamstechData.removeAll()
             self.placementsData.removeAll()
             self.affliationsData.removeAll()
             self.testimonialsData.removeAll()
   
                
                if let online_learning = response["online_learning"] as? [String: Any]{
                    
                  let learning_video = online_learning["learning_video"] as! String
                    
                       let playerVars: [String: Any] = [
                                "controls": 1,
                                "modestbranding": 1,
                               // "playsinline": 1,
                               // "autoplay": 1,
                                "origin": "https://youtube.com"
                            ]

                    self.videoPlayer.delegate = self

                    self.videoPlayer.loadWithVideoId(learning_video, with: playerVars)
                    
                    
                   let learning_text  = online_learning["learning_text"] as! String
                    self.onlinelearning_Lbl.text = learning_text
                    
                }
                
             if let dataArray = response["Home_page_slider"] as? [[String: Any]] {
               
             for list in dataArray {
             let object = homePageSliderDataResponseModel(data: list as NSDictionary)
             self.homePageSliderData.append(object)
             }
               
             self.bannersCollectionView.reloadData()
             }
               
             if let courseDataArray = response["course_details"] as? [[String: Any]] {
               
             for list in courseDataArray {
             let courseObject = courseDetailsDataResponseModel(data: list as NSDictionary)
             self.courseDetailsData.append(courseObject)
             }
              self.courseCollectionView.reloadData()

                
                
             }
            if let mentors = response["mentors_details"] as? [String: Any] {
                
                let post_content = mentors["post_content"] as! String
                
                self.mentors_Lbl.text = post_content
                
            if let mentorsDataArray = mentors["mentors_details"] as? [[String: Any]] {
                              
            for list in mentorsDataArray {
            let mentorsObject = mentorsDetailsDataResponseModel(data: list as NSDictionary)
            self.mentorsDetailsData.append(mentorsObject)
            }
                              
               self.mentorCollectionView.reloadData()
            }
            }
                
            if let whyHamstechDataArray = response["why_hamstech"] as? [[String: Any]] {
                              
            for list in whyHamstechDataArray {
            let whyHamstechObject = whyHamstechDataResponseModel(data: list as NSDictionary)
            self.whyHamstechData.append(whyHamstechObject)
            }
                              
              self.whyHamstechCollectionView.reloadData()
           }
                
            if let placement = response["placements"] as? [String: Any] {
                
             let placements_text = placement["placements_text"] as! String
                
                self.placement_Lbl.text = placements_text
                
                
            if let placementDataArray = placement["placements"] as? [[String: Any]] {
                              
            for list in placementDataArray {
            let placementObject = placementsDataResponseModel(data: list as NSDictionary)
            self.placementsData.append(placementObject)
            }
                              
               self.placementsCollectionView.reloadData()
            }
            }
                
                
            if let affliationSlider = response["affliations_slider"] as? [String: Any] {
                 
                
                let post_content = affliationSlider["post_content"] as! String
                    
                if post_content != "" {
                self.afflication_Lbl.text = post_content
                }
             if let affliationSliderDataArray = affliationSlider["affliations_details"] as? [[String: Any]] {
                
                
            for list in affliationSliderDataArray {
            let affliationsSliderObject = affliationsDataResponseModel(data: list as NSDictionary)
            self.affliationsData.append(affliationsSliderObject)
            }
              self.affliationsCollectionView.reloadData()
                }
                
                }
                
                
            if let testimonial = response["testimonials"] as? [String: Any] {
                    
                let testimonials_text = testimonial["testimonials_text"] as! String
        
               self.testinominal_Lbl.text = testimonials_text
            
                
                 if let testimonialDataArray = testimonial["testimonials"] as? [[String: Any]] {
                
            for list in testimonialDataArray {
            let testimonialObject = testimonialsDataResponseModel(data: list as NSDictionary)
            self.testimonialsData.append(testimonialObject)
            }
              self.testimonialsCollectionView.reloadData()
            }
            }
                
          self.hamstechview_Height.constant = CGFloat(self.whyHamstechData.count/2) * 218 + 70
            self.courses_Height.constant = CGFloat(self.courseDetailsData.count) * 60 + 55
          //  self.mainview_Height.constant = 2400 + self.courses_Height.constant
            
          // hamstechview_Height
           
            print("self.courseDetailsData.count", self.courseDetailsData.count)
               
                
        self.timer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(HomeViewController.autoScrollImageSlider), userInfo: nil, repeats: true)
                
        self.timer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(HomeViewController.autoScrollImageSlider1), userInfo: nil, repeats: true)
                
        RunLoop.main.add(self.timer, forMode: RunLoop.Mode.common)
                
                
                
           }else {
                 
               self.homePageSliderData.removeAll()
               self.courseDetailsData.removeAll()
               self.mentorsDetailsData.removeAll()
               self.whyHamstechData.removeAll()
               self.placementsData.removeAll()
               self.affliationsData.removeAll()
               self.testimonialsData.removeAll()

               self.bannersCollectionView.reloadData()
               self.courseCollectionView.reloadData()
               self.mentorCollectionView.reloadData()
               self.whyHamstechCollectionView.reloadData()
               self.placementsCollectionView.reloadData()
               self.affliationsCollectionView.reloadData()
               self.testimonialsCollectionView.reloadData()
                
    
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


extension HomeViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == bannersCollectionView {
            
            return homePageSliderData.count
        } else if collectionView == courseCollectionView {
            
            return courseDetailsData.count
            
        } else if collectionView == mentorCollectionView {
            
            return mentorsDetailsData.count
            
        } else if collectionView == whyHamstechCollectionView {
            
            return whyHamstechData.count
        } else if collectionView == placementsCollectionView {
            
            return placementsData.count
            
        } else if collectionView == affliationsCollectionView {
            
            return affliationsData.count
        } else if collectionView == testimonialsCollectionView{
            
            return testimonialsData.count
            
        } else {
            
           return 0
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
               
        
        
        
        
               if collectionView == bannersCollectionView {
                   
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! Home_BannerSliderCollectionViewCell
                
                if homePageSliderData[indexPath.row].sliderImage != nil {
                   
                    cell.bannerImage.setKFImage(with: homePageSliderData[indexPath.row].sliderImage)
                    
                }
                
                
                
               // cell.bannerImage.image = UIImage(named: cources[indexPath.row])
                
                return cell
                
               } else if collectionView == courseCollectionView {
                   
               let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! CourseCollectionViewCell

                
                cell.courceImg.setKFImage(with: courseDetailsData[indexPath.row].courseImage)
                  cell.courceLbl.text = courseDetailsData[indexPath.row].courseName
                
               
                
                
               // cell.courceImg.image = UIImage(named: cources[indexPath.row])
               // cell.courceLbl.text = cources1[indexPath.row]
//                                cell.shadowView.layer.cornerRadius = 5.0
//                                cell.shadowView.layer.borderWidth = 1.0
//                                cell.shadowView.layer.borderColor = UIColor.clear.cgColor
//                                cell.shadowView.layer.masksToBounds = true
//
//                                cell.layer.shadowColor = UIColor.lightGray.cgColor;
//                                cell.layer.shadowOffset = CGSize(width: 0, height: 2.0);
//                                cell.layer.shadowRadius = 2.0;
//                                cell.layer.shadowOpacity = 35;
//                                cell.layer.masksToBounds = false;
//                                cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath;

                
                      // Use the outlet in our custom class to get a reference to the UILabel in the cell
                   //cell.titleLabel.text = (self.array[indexPath.item] as! String)
                     // cell.titleLabel.text = "Hello"
                     // cell.backgroundColor = UIColor.cyan // make cell more visible in our example project
                    return cell

               } else if collectionView == mentorCollectionView {
                   let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! MentorCollectionViewCell

                                cell.mentorImages.layer.cornerRadius = 10.0
                                cell.mentorImages.layer.borderWidth = 1.0
                                cell.mentorImages.layer.borderColor = UIColor.clear.cgColor
                                cell.mentorImages.layer.masksToBounds = true
                
                  cell.mentorImages.setKFImage(with: mentorsDetailsData[indexPath.row].mentorsImage)
                    cell.mentorLabel.text = mentorsDetailsData[indexPath.row].mentorsTitle
                
                //cell.mentorImages.image = UIImage(named: m[indexPath.row])
//                                cell.layer.shadowColor = UIColor.lightGray.cgColor;
//                                cell.layer.shadowOffset = CGSize(width: 0, height: 2.0);
//                                cell.layer.shadowRadius = 2.0;
//                                cell.layer.shadowOpacity = 35;
//                                cell.layer.masksToBounds = false;
//                                cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath;

                    return cell
                   
               }else if collectionView == whyHamstechCollectionView {
                
                   let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! WhyHamstechCollectionViewCell
                
                cell.hamstechCellView.layer.cornerRadius = 25
                cell.hamstechCellView.layer.borderWidth = 1.0
                cell.hamstechCellView.layer.borderColor = UIColor.clear.cgColor
                cell.hamstechCellView.layer.masksToBounds = true
                
                cell.whyHamstechImg.setKFImage(with: whyHamstechData[indexPath.row].uploadImages)
 
               // cell.whyHamstechImg.image = UIImage(named: h[indexPath.row])
                
//                if indexPath.row == 2 || indexPath.row == 5 || indexPath.row == 8 {
//
//                    cell.leading.constant = whyHamstechCollectionView.frame.size.width/4
//                    cell.trailing.constant = whyHamstechCollectionView.frame.size.width/4
//
//                } else {
//
//                   cell.leading.constant = 10
//                   cell.trailing.constant = 10
//
//                }
                
                return cell

               }else if collectionView == placementsCollectionView {
                
                   let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! PlacementsCollectionViewCell
                
                cell.placementImg.setKFImage(with: placementsData[indexPath.row].placementImages)
                
               // cell.placementImg.image = UIImage(named: p[indexPath.row])
            
                return cell

               }else if collectionView == affliationsCollectionView {
                   
                      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! Home_AffliationCollectionViewCell
                   
                cell.affliationImg.setKFImage(with: affliationsData[indexPath.row].affliationImages)
                
               // cell.affliationImg.image = UIImage(named: m[indexPath.row])
                
                   return cell

                  }else {
                
                   let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! TestimonialsCollectionViewCell
                    
                               cell.TestimonialsShadowView.layer.cornerRadius = 10
                               cell.TestimonialsShadowView.layer.borderWidth = 1.0
                               cell.TestimonialsShadowView.layer.borderColor = UIColor.clear.cgColor
                               cell.TestimonialsShadowView.layer.masksToBounds = true
                
             
                            cell.testimonialImage.setKFImage(with: testimonialsData[indexPath.row].affliationImages)
                            cell.testimonialDescription.text = testimonialsData[indexPath.row].affliationDescription
                            cell.testimonialTitle.text = testimonialsData[indexPath.row].affliationTitle
                            cell.testimonialPosition.text = testimonialsData[indexPath.row].affliationPosition
                
                
                            cell.testimonialDescription.lineBreakMode = .byClipping
                            cell.testimonialPosition.lineBreakMode = .byClipping
                
                
                
                
//               let indexPath = IndexPath(item: (currentItemIndex?.item ?? -1) + 1, section: 0)
//
//                let delay = 0.55 + Double(indexPath.row) * 0.130; //calculate delay
//                print(delay) // print for sure
//
//                UIView.animate(withDuration: 0.2, delay: delay, options: .curveEaseIn, animations: {
//                    self.testimonialsCollectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true) // do animation after delay
//                }, completion: nil)


                //  testimonialsCollectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
                
             
                
                // Automatic scrolling testimonials
                
//                var rowIndex = indexPath.row
//                let Numberofrecords : Int = testimonialsData.count - 1
//                if (rowIndex < Numberofrecords)
//                {
//                    rowIndex = (rowIndex + 0) // 1
//                }
//                else
//                {
//                    rowIndex = 0
//                }
//
//                Scrollinftimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(HomeViewController.startTimer(timersset:)), userInfo: rowIndex, repeats: true)
// end
                   return cell
        }
}
  
    
    
      func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
    
          if collectionView == bannersCollectionView {
          return CGSize(width: (CGFloat) (self.bannersCollectionView.frame.size.width) ,height: (CGFloat) (self.bannersCollectionView.frame.size.height))
          } else if collectionView == courseCollectionView {
            
            return CGSize(width: (CGFloat) (self.courseCollectionView.frame.size.width) ,height: 60)
          } else if collectionView == mentorCollectionView {
            
           return CGSize(width: (CGFloat) (self.mentorCollectionView.frame.size.width/2) ,height: (CGFloat) (self.mentorCollectionView.frame.size.height/2))
            
          } else if collectionView == whyHamstechCollectionView {
            
//            if indexPath.row == 2 {
//
//                return CGSize(width: (CGFloat) (self.whyHamstechCollectionView.frame.size.width) ,height: self.whyHamstechCollectionView.frame.size.height/3)
//
//            } else {
            
            return CGSize(width: (CGFloat) (self.whyHamstechCollectionView.frame.size.width/2) ,height: (CGFloat) (218))
                
          //  }
          } else if collectionView == placementsCollectionView {
            
            return CGSize(width: (CGFloat) (self.placementsCollectionView.frame.size.width/3) ,height: (CGFloat) (self.placementsCollectionView.frame.size.height))
            
          } else if collectionView == affliationsCollectionView {
            
            return CGSize(width: (CGFloat) (self.affliationsCollectionView.frame.size.width) ,height: (CGFloat) (self.affliationsCollectionView.frame.size.height))
            
          } else if collectionView == testimonialsCollectionView {
  
         return CGSize(width: (CGFloat) (self.testimonialsCollectionView.frame.size.width-80) ,height: (CGFloat) (self.testimonialsCollectionView.frame.size.height))
            
          } else {
            
            return CGSize(width: (CGFloat) (0) ,height: (CGFloat) (0))
        }
      }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    
        if collectionView == bannersCollectionView {
            self.bannerpagecontroler.numberOfPages = homePageSliderData.count
        self.bannerpagecontroler.currentPage = indexPath.row
        } else if collectionView == affliationsCollectionView {
            self.affliationspagecontroller.numberOfPages = affliationsData.count
        self.affliationspagecontroller.currentPage = indexPath.row
        } else if collectionView == testimonialsCollectionView {
            
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.testimonialsCollectionView
        {
             print("itm selected == \(indexPath.row)")
            
        } else if collectionView == courseCollectionView {
            
            ActivityServiceCalling(Pagename: "HomeViewController", Activity: "Categoty")
           
         
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "FashondesigningViewController") as? FashondesigningViewController
                 vc?.fromsidemenu = true
                vc?.catname = courseDetailsData[indexPath.row].categoryname
            vc?.catid = courseDetailsData[indexPath.row].categoryId
            self.navigationController?.pushViewController(vc!, animated: true)
       
              
         
        } else if collectionView == affliationsCollectionView {
            
            ActivityServiceCalling(Pagename: "HomeViewController", Activity: "Afflication")
           
            
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AffliationsViewController") as? AffliationsViewController
            self.navigationController?.pushViewController(vc!, animated: true)
            
            
        } else if collectionView == mentorCollectionView {
            
            ActivityServiceCalling(Pagename: "HomeViewController", Activity: "Mentors")
         
            
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MentorsViewController") as? MentorsViewController
            self.navigationController?.pushViewController(vc!, animated: true)
            
            
        } else if collectionView == bannersCollectionView {
            
            ActivityServiceCalling(Pagename: "HomeViewController", Activity: "Banner")
              
               let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "FashondesigningViewController") as? FashondesigningViewController
                    vc?.fromsidemenu = true
                   vc?.catname = courseDetailsData[indexPath.row].categoryname
               vc?.catid = courseDetailsData[indexPath.row].categoryId
               self.navigationController?.pushViewController(vc!, animated: true)
            
            
            
        }
        
        
        
    }
        
    
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

            let layout = self.testimonialsCollectionView.collectionViewLayout as! UPCarouselFlowLayout
            let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
            let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
            HomeViewController.currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
        }

//        fileprivate var currentPage1: Int = 0 {
//            didSet {
//                print("page at centre = \(currentPage)")
//            }
//        }
//
        fileprivate var pageSize: CGSize {

            let layout = self.testimonialsCollectionView.collectionViewLayout as! UPCarouselFlowLayout
            var pageSize = layout.itemSize
            if layout.scrollDirection == .horizontal {
                pageSize.width += layout.minimumLineSpacing
            } else {
                pageSize.height += layout.minimumLineSpacing
            }
            return pageSize
        }
    
    

    @objc func startTimer(timersset : Timer)
    {
        //UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseOut, animations:
        //{
            self.testimonialsCollectionView.scrollToItem(at: IndexPath(row: timersset.userInfo! as! Int,section:0), at: .centeredHorizontally, animated: false)
       // }, completion: nil)




    }
    
    
    

    // Force Update

          func needsUpdate() -> Bool {

               print("forceupdate")
               let infoDictionary = Bundle.main.infoDictionary
               let appID = infoDictionary!["CFBundleIdentifier"] as! String
               let url = URL(string: "http://itunes.apple.com/lookup?bundleId=\(appID)")
               guard let data = try? Data(contentsOf: url!) else {
                 print("There is an error!")
                 return false;
               }
               let lookup = (try? JSONSerialization.jsonObject(with: data , options: [])) as? [String: Any]
               if let resultCount = lookup!["resultCount"] as? Int, resultCount == 1 {
                   if let results = lookup!["results"] as? [[String:Any]] {
                       if let appStoreVersion = results[0]["version"] as? String{
                           let currentVersion = infoDictionary!["CFBundleShortVersionString"] as? String
                           if (currentVersion! < appStoreVersion) {
                               self.forceUpdate(currentVersion, toVersion:appStoreVersion)
                               print("Need to update [\(appStoreVersion) != \(currentVersion)]")
                               return true
                           }
                       }
                   }
               }
               return false
           }
           
       //Force Update Api Calling
           func forceUpdate(_ currentVersion: String?, toVersion appstoreVersion: String?) {
               print("Api calling")
               
               if Reachability.isConnectedToNetwork(){
               let Urlname = "\(ConstantsKeys.AppLinks.BaseUrl)\(ConstantsKeys.AppGetUrls.forceUpadte)"
       
                 let params  = ["device":"ios","userId":currentVersion, "appstoreId":appstoreVersion]  as [String : Any]
       
                   ActivityIndicatorWithLabel.shared.showProgressView(uiView: view)
                   NetworkHelper.sharedInstance.postServiceCall(url: Urlname, PostDetails: params as [String : AnyObject]) { (response, error)  in
       
                       ActivityIndicatorWithLabel.shared.hideProgressView()
       
                                         let status = String(response["status"] as! String)
                                         
                                         if (status == "ok") {
                                         let updateStatus:String = String(response["update_status"] as! String)
       
                                         if updateStatus == "Force" {
       
                                         let alertView = UIAlertView(title: "New Version Available", message:"New update available", delegate: self, cancelButtonTitle:nil, otherButtonTitles: "Update")
                                            alertView.show()
                                           
                                         } else {
       
                                           // Do nothing
                                           print("No force update available")
                                   
                                         }
       
       
                                       }
       
                                       }
                                      }
       
                                       else
                                       {
                                           self.customPresentAlert(withTitle: "", message: "Please Check Network Connection")
                                       }
                                   }
           
           func alertView(_ actionSheet: UIAlertView, clickedButtonAt buttonIndex: Int) {
               if buttonIndex == 0 {
                   let iTunesLink = ""    //https://itunes.apple.com/us/app/arre/id1185288678?ls=1&mt=8"
                   if let url = URL(string: iTunesLink) {
                       UIApplication.shared.openURL(url)
                   }
               }
           }


        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }


    }


  

