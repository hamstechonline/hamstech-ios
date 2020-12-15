//
//  FashondesigningViewController.swift
//  hamstech
//
//  Created by Priyanka on 08/05/20.
//

import UIKit
import SideMenu
import YoutubePlayerView

class FashondesigningViewController: UIViewController, YoutubePlayerViewDelegate, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var videoPlayer: YoutubePlayerView!
    @IBOutlet weak var courseTableView: UITableView!
    @IBOutlet weak var CarrearCollectionView: UICollectionView!
    @IBOutlet weak var whyHamstechCollectionView: UICollectionView!
    @IBOutlet weak var placementsCollectionView: UICollectionView!
    @IBOutlet weak var testimonialsCollectionView: UICollectionView!
    @IBOutlet weak var carrerView: UIView!
    @IBOutlet weak var courcesView: UIView!
    @IBOutlet weak var catname_Lbl: UILabel!
    
    @IBOutlet weak var back_But: UIButton!
    @IBOutlet weak var whyhamstach_Height: NSLayoutConstraint!
    @IBOutlet weak var courses_Height: NSLayoutConstraint!
    @IBOutlet weak var carrer_Height: NSLayoutConstraint!
    @IBOutlet weak var carrerback_View: UIView!
    
    @IBOutlet weak var screenTitle: UILabel!
    
    var catname = String()
    var catid = String()
     var fromsidemenu = Bool()
//   var cources = ["c1","c2","c3","c4","c5","c6","c7"]
    var h = ["h1","h2","h3","h4","h5"]

    var timer2:Timer!
    
    static var currentPage: Int = 0

   var courseCareerOptionData  =  [careerOptionsDataResponseModel]()
   var courseListData =           [courseListDataResponseModel]()
   var coursePlacementData    =   [coursePlacementsDataResponseModel]()
   var courseWhyHamstechData   =  [courseWhyHamstechDataResponseModel]()
   var courseTestimonialData   =  [courseTestimonialsDataResponseModel]()
      
   
                  
    override func viewDidLoad() {
    super.viewDidLoad()

   ActivityServiceCalling(Pagename: "Categorey", Activity: "Viewed")
        
        
        
    if fromsidemenu == true {
        
        back_But.isHidden = false
        
    } else {
        
       back_But.isHidden = true
    }
        
    screenTitle.text = catname
    catname_Lbl.text = "Programmes in \(catname)"
    self.courseServiceCalling()

//    // Video
//
//    let playerVars: [String: Any] = [
//    "controls": 1,
//    "modestbranding": 1,
//    "playsinline": 1,
//    "autoplay": 1,
//    "origin": "https://youtube.com"
//    ]
//    videoPlayer.delegate = self
//    videoPlayer.loadWithVideoId("VJMtR5t5rfg", with: playerVars)




    //        let strYoutubeKey = extractYoutubeIdFromLink(link: strVideoUrl)
    //        if(strYoutubeKey != nil){
    //           // self.playerView.load(withVideoId:"84lmw1sFpHw", playerVars: playerVars)
    //            videoPlayer.loadWithVideoId(strYoutubeKey!, with: playerVars)
    //        }

    let floawLayout = UPCarouselFlowLayout()
    floawLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 60.0, height: testimonialsCollectionView.frame.size.height)
    floawLayout.scrollDirection = .horizontal
    floawLayout.sideItemScale = 0.8
    floawLayout.sideItemAlpha = 1.0
    floawLayout.spacingMode = .fixed(spacing: 5.0)
    testimonialsCollectionView.collectionViewLayout = floawLayout


    carrerback_View.layer.cornerRadius = 15
    courcesView.layer.cornerRadius = 20


        
    }


    override func viewWillLayoutSubviews() {
         super.updateViewConstraints()
          self.courses_Height.constant = courseTableView.contentSize.height + 66
     }
    
    override func viewWillAppear(_ animated: Bool) {
    catname_Lbl.isHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
    catname_Lbl.isHidden = true
    }



    @IBAction func whatsAppAction(_ sender: Any) {

   ActivityServiceCalling(Pagename: "Categorey", Activity: "Chat")
        
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

    @IBAction func backButtonAction(_ sender: Any) {

    self.navigationController?.popViewController(animated: true)

    }
    //    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //        videoPlayer.pause()
    //    }

    // YoutubePlayerView delegate methods
    func playerViewDidBecomeReady(_ playerView: YoutubePlayerView) {
    print("Ready")
    
        
    playerView.fetchPlayerState { (state) in
    print("Fetch Player State: \(state)")
    }
    }

    func playerView(_ playerView: YoutubePlayerView, didChangedToState state: YoutubePlayerState) {
    print("Changed to state: \(state)")
    }

    func playerView(_ playerView: YoutubePlayerView, didChangeToQuality quality: YoutubePlaybackQuality) {
    print("Changed to quality: \(quality)")
    }

    func playerView(_ playerView: YoutubePlayerView, receivedError error: Error) {
    print("Error: \(error)")
    }

    func playerView(_ playerView: YoutubePlayerView, didPlayTime time: Float) {
    print("Play time: \(time)")
    }

    func playerViewPreferredInitialLoadingView(_ playerView: YoutubePlayerView) -> UIView? {
    let activityView = UIActivityIndicatorView(style: .gray)
    activityView.center = self.view.center
    activityView.startAnimating()
    return activityView
    }

    //    func extractYoutubeIdFromLink(link: String) -> String? {
    //        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"
    //        guard let regExp = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else {
    //            return nil
    //        }
    //        let nsLink = link as NSString
    //        let options = NSRegularExpression.MatchingOptions(rawValue: 0)
    //        let range = NSRange(location: 0, length: nsLink.length)
    //        let matches = regExp.matches(in: link as String, options:options, range:range)
    //        if let firstMatch = matches.first {
    //            return nsLink.substring(with: firstMatch.range)
    //        }
    //        return nil
    //    }


    // servicecall
    func courseServiceCalling() {

    if Reachability.isConnectedToNetwork(){


    let Urlname = "\(ConstantsKeys.AppLinks.BaseUrl)\(ConstantsKeys.AppGetUrls.courseDetail)"

    let params  = ["metadata": ["appname":"Hamstech", "apikey": "dsf99898398i3jofklese93","page": "hamstech_career_page","categoryId":catid] ] as [String : Any]



    ActivityIndicatorWithLabel.shared.showProgressView(uiView: view)
    NetworkHelper.sharedInstance.postServiceCall(url: Urlname, PostDetails: params as [String : AnyObject]) { (response, error) in
    ActivityIndicatorWithLabel.shared.hideProgressView()

    let status:String =  String(response["status"] as! String)

    if status == "ok"{

    if let course_video = response["course_video"] as? [[String: Any]] {
            
          // Video
            
            if course_video.count != 0 {
            
            let video_url = course_video[0]["video_url"] as! String
            
              
          let playerVars: [String: Any] = [
          "controls": 1,
          "modestbranding": 1,
          "playsinline": 1,
          "autoplay": 1,
          "origin": "https://youtube.com"
          ]
          self.videoPlayer.delegate = self
          self.videoPlayer.loadWithVideoId(video_url, with: playerVars)
     
        }
        
        }
        
    self.courseCareerOptionData.removeAll()
    self.courseCareerOptionData.removeAll()
    self.coursePlacementData.removeAll()
    self.courseWhyHamstechData.removeAll()
    self.courseTestimonialData.removeAll()


    if let courseCareerOptionDataArray = response["career_options"] as? [[String: Any]] {

    for list in courseCareerOptionDataArray {
    let careerOptionObject = careerOptionsDataResponseModel(data: list as NSDictionary)
    self.courseCareerOptionData.append(careerOptionObject)
    }

   // self.carrer_Height.constant =  CGFloat(self.courseCareerOptionData.count*35) + 66
    self.CarrearCollectionView.reloadData()
    }

    if let courseListDataArray = response["course_list"] as? [[String: Any]] {

    for list in courseListDataArray {
    let courseListObject = courseListDataResponseModel(data: list as NSDictionary)
    self.courseListData.append(courseListObject)
    }
  //  self.courses_Height.constant = CGFloat(self.courseListData.count*55) + 66
    self.courseTableView.reloadData()
    }
    if let coursePlacementsDataArray = response["placements"] as? [[String: Any]] {

    for list in coursePlacementsDataArray {
    let coursePlacementsObject = coursePlacementsDataResponseModel(data: list as NSDictionary)
    self.coursePlacementData.append(coursePlacementsObject)
    }

    self.placementsCollectionView.reloadData()
    }
    if let courseTestimonialDataArray = response["testimonials"] as? [[String: Any]] {

    for list in courseTestimonialDataArray {
    let coursePlacementObject = courseTestimonialsDataResponseModel(data: list as NSDictionary)
    self.courseTestimonialData.append(coursePlacementObject)
    }

    self.testimonialsCollectionView.reloadData()
    }
    if let courseWhyHamstechDataArray = response["why_hamstech"] as? [[String: Any]] {

    for list in courseWhyHamstechDataArray {
    let courseWhyHamstechObject = courseWhyHamstechDataResponseModel(data: list as NSDictionary)
    self.courseWhyHamstechData.append(courseWhyHamstechObject)
    }
    self.whyhamstach_Height.constant = CGFloat(self.courseWhyHamstechData.count/2*220) + 66
    self.whyHamstechCollectionView.reloadData()
    }

    }
    else {


    self.courseCareerOptionData.removeAll()
    self.courseCareerOptionData.removeAll()
    self.coursePlacementData.removeAll()
    self.courseWhyHamstechData.removeAll()
    self.courseTestimonialData.removeAll()

    self.CarrearCollectionView.reloadData()
    self.courseTableView.reloadData()
    self.placementsCollectionView.reloadData()
    self.whyHamstechCollectionView.reloadData()
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

    @IBAction func viewmore_Action(_ sender: Any) {
          
   
          let story = UIStoryboard.init(name: "Main", bundle: nil)
          let cartVC = story.instantiateViewController(withIdentifier: "CarreroptionspopupViewController") as! CarreroptionspopupViewController
        cartVC.courseCareerOptionData = self.courseCareerOptionData
         
          var viewcontroller = UIApplication.shared.keyWindow?.rootViewController
          let navigation = UINavigationController.init(rootViewController: cartVC)
          navigation.modalPresentationStyle = .overCurrentContext
          while ((viewcontroller?.presentedViewController) != nil){
          viewcontroller = viewcontroller?.presentedViewController
          }
          viewcontroller?.present(navigation, animated: false, completion: nil)
          
          
    
          
      }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           
          return courseListData.count
           
          }
          
          func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
              let cell = courseTableView.dequeueReusableCell(withIdentifier: "CoursesCell1", for: indexPath) as! CoursesCell1
           
        

           cell.coucesLbl.text = courseListData[indexPath.row].courseName

           return cell
          }

       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           
           return UITableView.automaticDimension
       }
       
       
       func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
           self.viewWillLayoutSubviews()
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
         ActivityServiceCalling(Pagename: "Categorey", Activity: "ClickedonCource")
                      
           let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "FashionStylingViewController") as? FashionStylingViewController

           vc?.catname = courseListData[indexPath.row].courseName
           vc?.courceid = courseListData[indexPath.row].courseId
           vc?.catid = self.catid

           self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    
    }
    extension FashondesigningViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

    if collectionView == CarrearCollectionView {

    return courseCareerOptionData.count

    }  else if collectionView == whyHamstechCollectionView {

    return courseWhyHamstechData.count
    } else if collectionView == placementsCollectionView {

    return coursePlacementData.count
    }
    else if collectionView == testimonialsCollectionView{

    return courseTestimonialData.count
    } else {

    return 0
    }


    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    if collectionView == CarrearCollectionView {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! fashondesigningCollectionViewCell

        if courseCareerOptionData.count > 1 && indexPath.row == 0{
           
            cell.fashonLbl.text = courseCareerOptionData[0].careerOptions
            
        }
        
        if courseCareerOptionData.count > 2 && indexPath.row == 1{
           
            cell.fashonLbl.text = courseCareerOptionData[1].careerOptions
            
        }
        if courseCareerOptionData.count > 3 && indexPath.row == 2{
           
            cell.fashonLbl.text = courseCareerOptionData[2].careerOptions
            
        }
        if courseCareerOptionData.count > 4 && indexPath.row == 3{
           
            cell.fashonLbl.text = courseCareerOptionData[3].careerOptions
            
        }
        
    

    return cell

    }else if collectionView == whyHamstechCollectionView {

    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! WhyHamstech

    cell.hamstechCellView.layer.cornerRadius = 25
    cell.hamstechCellView.layer.borderWidth = 1.0
    cell.hamstechCellView.layer.borderColor = UIColor.clear.cgColor
    cell.hamstechCellView.layer.masksToBounds = true

    cell.img.setKFImage(with: courseWhyHamstechData[indexPath.row].courseUploadImages)


    //cell.hamstechCellImg.image = UIImage(named: h[indexPath.row])

    //                            if indexPath.row == 2 {
    //
    //                                cell.leading.constant = whyHamstechCollectionView.frame.size.width/4
    //                                cell.trailing.constant = whyHamstechCollectionView.frame.size.width/4
    //
    //                            } else {
    //
    //                               cell.leading.constant = 10
    //                               cell.trailing.constant = 10
    //
    //                            }

    return cell

    }else if collectionView == placementsCollectionView {

    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! PlacementCell

    cell.placementImg.setKFImage(with: coursePlacementData[indexPath.row].coursePlacementImages)

    //cell.placementImg.image = UIImage(named: p[indexPath.row])

    return cell

    }else {

    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! TestimonialsCell




    cell.TestimonialsShadowView.layer.cornerRadius = 10
    cell.TestimonialsShadowView.layer.borderWidth = 1.0
    cell.TestimonialsShadowView.layer.borderColor = UIColor.clear.cgColor
    cell.TestimonialsShadowView.layer.masksToBounds = true


    cell.courseTestimonialImage.setKFImage(with: courseTestimonialData[indexPath.row].courseAddImage)
    cell.courseTestimonialDescription.text = courseTestimonialData[indexPath.row].courseDescription
    cell.courseTestimonialTitle.text = courseTestimonialData[indexPath.row].courseTitle
    cell.courseTestimonialPosition.text = courseTestimonialData[indexPath.row].coursePosition

    cell.courseTestimonialDescription.lineBreakMode = .byClipping
    cell.courseTestimonialPosition.lineBreakMode = .byClipping
        
        
        

    return cell
    }
    }



    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {


    if collectionView == CarrearCollectionView {

    return CGSize(width: (CGFloat) (self.CarrearCollectionView.frame.size.width) ,height: (CGFloat) (self.CarrearCollectionView.frame.size.height/4))

    }
//    else if collectionView == courseCollectionView {
//
//    return CGSize(width: (CGFloat) (self.courseCollectionView.frame.size.width) ,height: (CGFloat) (55))
//
//    }
    else if collectionView == whyHamstechCollectionView {

    //                        if indexPath.row == 2 {
    //
    //                            return CGSize(width: (CGFloat) (self.whyHamstechCollectionView.frame.size.width) ,height: (CGFloat) (self.whyHamstechCollectionView.frame.size.height/3))
    //
    //                        } else {

    return CGSize(width: (CGFloat) (self.whyHamstechCollectionView.frame.size.width/2) ,height: (CGFloat) (218))

    //   }
    } else if collectionView == placementsCollectionView {

    return CGSize(width: (CGFloat) (self.placementsCollectionView.frame.size.width/3) ,height: (CGFloat) (self.placementsCollectionView.frame.size.height))

    }  else {

    return CGSize(width: (CGFloat) (self.testimonialsCollectionView.frame.size.width-80) ,height: (CGFloat) (self.testimonialsCollectionView.frame.size.height))

    }
    }



    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    if collectionView == self.courseCollectionView
//    {

    ActivityServiceCalling(Pagename: "Categorey", Activity: "ClickedonCource")
               
    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "FashionStylingViewController") as? FashionStylingViewController

    vc?.catname = courseListData[indexPath.row].courseName
    vc?.courceid = courseListData[indexPath.row].courseId
    vc?.catid = self.catid

    self.navigationController?.pushViewController(vc!, animated: true)



  //  }
    }


    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let layout = self.testimonialsCollectionView.collectionViewLayout as! UPCarouselFlowLayout
    let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
    let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
    HomeViewController.currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
    }

    //        fileprivate var currentPage: Int = 0 {
    //            didSet {
    //                print("page at centre = \(currentPage)")
    //            }
    //        }

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

    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    }


    }






