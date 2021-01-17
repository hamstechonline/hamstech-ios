//
//  FashionStylingViewController.swift
//  hamstech
//
//  Created by Priyanka on 07/05/20.
//

import UIKit
import SideMenu

class FashionStylingViewController: UIViewController,SearchSendingDelegate {
    func Searchdata(courceid: String, Catid: String, catname: String) {
       
        subcat_Lbl.text = catname
        self.courceid = courceid
        self.catid = Catid
        fasionstyleservicecalling()
    }
    

 

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var durationView: UIView!
    @IBOutlet weak var courseCurriculumView: UIView!
    @IBOutlet weak var chatWithUsView: UIView!
    
    @IBOutlet weak var subcat_Lbl: UILabel!
    @IBOutlet weak var overview_Txt: UITextView!
    @IBOutlet weak var duration_Lbl: UILabel!
    @IBOutlet weak var elgibility_Lbl: UILabel!
   // @IBOutlet weak var curriculum: UILabel!
    @IBOutlet weak var entrol_But: UIButton!
    
    @IBOutlet weak var courseCurriculumTable: UITableView!
    
    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var overview_Height: NSLayoutConstraint!
    
    
    var catname = String()
    var catid = String()
    var courceid = String()
    var overviewbool = Bool()
   
    var courseCurriculumData = [FashionStylingResponseModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
      ActivityServiceCalling(Pagename: "Course", Activity: "Viewed")
        
        subcat_Lbl.text = catname
        applyShadowOnView(overView)
        applyShadowOnView(durationView)
        applyShadowOnView(courseCurriculumView)
        applyShadowOnView(chatWithUsView)
        applyShadowOnView(entrol_But)
        chatWithUsView.layer.cornerRadius = 25
        fasionstyleservicecalling()

    }
// Applying shadow on UIViews
//    func applyShadowOnView(_ view:UIView) {
//
//            view.layer.cornerRadius = 8
//            view.layer.shadowColor = UIColor.lightGray.cgColor
//            view.layer.shadowOpacity = 1
//            view.layer.shadowOffset = CGSize.zero
//            view.layer.shadowRadius = 5
//
//    }

    override func viewWillAppear(_ animated: Bool) {
        subcat_Lbl.isHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        subcat_Lbl.isHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        height.constant = courseCurriculumTable.contentSize.height + 70
    }
    
    
    @IBAction func entrol_Action(_ sender: Any) {
        
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController
//        self.navigationController?.pushViewController(vc!, animated: true)
        
        let story = UIStoryboard.init(name: "Main", bundle: nil)
               let cartVC = story.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController

               var viewcontroller = UIApplication.shared.keyWindow?.rootViewController
               let navigation = UINavigationController.init(rootViewController: cartVC)
               navigation.modalPresentationStyle = .overCurrentContext
               while ((viewcontroller?.presentedViewController) != nil){
               viewcontroller = viewcontroller?.presentedViewController
               }
               viewcontroller?.present(navigation, animated: false, completion: nil)
               
               
    }
    
    @IBAction func whatsAppAction(_ sender: Any) {
       
        ActivityServiceCalling(Pagename: "Course", Activity: "Chat")
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
      
        
        ActivityServiceCalling(Pagename: "Course", Activity: "Search")
        
        let story = UIStoryboard.init(name: "Main", bundle: nil)
        let cartVC = story.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        cartVC.from = "Fashionstyling"
        cartVC.Searchdelegate = self
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
    
    @IBAction func chatwithus_Action(_ sender: Any) {
       
         ActivityServiceCalling(Pagename: "Course", Activity: "Chat")
        
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
    
    @IBAction func viewmore_Action(_ sender: Any) {
          
        
        if overviewbool == true {
            
            overviewbool = false
            overview_Height.constant = 85
            
        } else {
          
            overviewbool = true
            overview_Height.constant = self.overview_Txt.contentSize.height + 85
            
        }
        
        
//          ActivityServiceCalling(Pagename: "Mentores", Activity: "Viewmore")
//
//          let story = UIStoryboard.init(name: "Main", bundle: nil)
//          let cartVC = story.instantiateViewController(withIdentifier: "OverviewPopupViewController") as! OverviewPopupViewController
//            cartVC.overviewtxt = overview_Txt.text!
//
//          var viewcontroller = UIApplication.shared.keyWindow?.rootViewController
//          let navigation = UINavigationController.init(rootViewController: cartVC)
//          navigation.modalPresentationStyle = .overCurrentContext
//          while ((viewcontroller?.presentedViewController) != nil){
//          viewcontroller = viewcontroller?.presentedViewController
//          }
//          viewcontroller?.present(navigation, animated: false, completion: nil)
//
          
    
          
      }
    
    
    
    
    @IBAction func backButtonAction(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
       _ = self.navigationController?.popViewController(animated: true)
    }
    
    func fasionstyleservicecalling(){

             if Reachability.isConnectedToNetwork(){

            
                let Urlname = "\(ConstantsKeys.AppLinks.BaseUrl)\(ConstantsKeys.AppGetUrls.get_coursecurriculum_bycat)"

                
              
    let params  = ["metadata":["appname":"Hamstech","page":"hamstech_curriculum_page","apikey":"dsf99898398i3jofklese93","categoryId":catid,"courseId":courceid]]

              
                
           ActivityIndicatorWithLabel.shared.showProgressView(uiView: view)
             NetworkHelper.sharedInstance.postServiceCall(url: Urlname, PostDetails: params as [String : AnyObject]) { (response, error) in
             ActivityIndicatorWithLabel.shared.hideProgressView()
                 
             let status:String =  String(response["status"] as! String)

                if status == "ok"{
                    
             self.courseCurriculumData.removeAll()
                    
            if let curriculumOptionsDataArray = response["curriculum_options"] as? [[String: Any]] {
                              
            for list in curriculumOptionsDataArray {
            
            let Object = FashionStylingResponseModel(data: list as NSDictionary)
            self.courseCurriculumData.append(Object)
            }
                              
               self.courseCurriculumTable.reloadData()
            }
            
                    
                    
                    
            let course_list = response["course_list"] as! [[String:Any]]
            if course_list.count != 0 {
              
           // let course_name = course_list[0]["course_name"] as! String
            let duration = course_list[0]["duration"] as! String
            let eligibility = course_list[0]["eligibility"] as! String
            let introduction = course_list[0]["introduction"] as! String
           // let course_syllabus = course_list[0]["course_syllabus"] as! String
            let image_url = course_list[0]["image_url"] as! String
                
            self.topImage.setKFImage(with: image_url)
            
            self.overview_Txt.text = introduction
            self.duration_Lbl.text = "Duration: \(duration)"
            self.elgibility_Lbl.text = "Eligibility: \(eligibility)"
           // self.curriculum.text = course_syllabus
                
                
                
            }
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
    
    
    
}

extension FashionStylingViewController: UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           
          return courseCurriculumData.count
           
          }
          
          func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
              let cell = courseCurriculumTable.dequeueReusableCell(withIdentifier: "FashionStylingCell", for: indexPath) as! FashionStylingCell
           
            cell.curiculumLabel.text = courseCurriculumData[indexPath.row].curriculumString ?? ""
           
           return cell
          }

       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           
           return UITableView.automaticDimension
       }
       
       
       func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
           self.viewWillLayoutSubviews()
       }

}
    



