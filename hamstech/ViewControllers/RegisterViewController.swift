//
//  RegisterViewController.swift
//  hamstech
//
//  Created by Priyanka on 25/05/20.
//

import UIKit
import SideMenu

class RegisterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var courses_Table: UITableView!
    @IBOutlet weak var table_Height: NSLayoutConstraint!
    @IBOutlet weak var contentview_Height: NSLayoutConstraint!
    @IBOutlet weak var selectedcoucesview_Height: NSLayoutConstraint!
    @IBOutlet weak var selected_View: UIView!
    @IBOutlet weak var choosecourse_img: UIImageView!
    @IBOutlet weak var Choosecourse_View: UIView!
    @IBOutlet weak var creditcard_View: UIView!
    @IBOutlet weak var debitcard_View: UIView!
    @IBOutlet weak var internetbanking_View: UIView!
    @IBOutlet weak var upwallet_View: UIView!
    @IBOutlet weak var paynow_But: UIButton!
    @IBOutlet weak var creditCardImage: UIImageView!
    @IBOutlet weak var debitCardImage: UIImageView!
    @IBOutlet weak var bankingImage: UIImageView!
    @IBOutlet weak var walletImage: UIImageView!
    @IBOutlet weak var chooseoption_Height: NSLayoutConstraint!
    @IBOutlet weak var catname_Lbl: UILabel!
    @IBOutlet weak var courcename_Lbl: UILabel!
    @IBOutlet weak var cource_Img: UIImageView!
    @IBOutlet weak var selected_Img: UIImageView!
    @IBOutlet weak var pricedescription_Lbl: UILabel!
    
    
     var SearchistingData = [SearchResponseModel]()
     var registerid = [String]()
     var registerData = [String]()
     var registerimageData = [String]()
    var registerprizeData = [String]()
     var catname = String()
     var courseDetailsData  =  [courseDetailsDataResponseModel]()
     var price = String()
    
    var courseselected = false
    var Paymentselected = false
    var from = String()
    
   // var header = ["Fashion Design","Fashion Design","Fashion Design","Fashion Design","Fashion Design","Fashion Design","Fashion Design"]
    
   //  var inner = ["BA(Hons) in Fashion Design","Diploma in Textile & Fashion Design (SNDT)","Certificate Course in Fashion Desining and Garment Making","Certificate Course in Fashion Design","18 Months Programe in Fashion Design"]
    
    private let headerIdentifier = "RegistercoursesCell"
    private let cellIdentifier = "RegisterSubcoursesCell"
    
     private var sectionIsExpanded =  [Bool]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ActivityServiceCalling(Pagename: "RegisterCourse", Activity: "Viewed")
//        for _ in 0..<header.count {
//
//        self.sectionIsExpanded.append(false)
//
//        }
     
        
        
        table_Height.constant = 0
        courses_Table.isHidden = true
        selected_View.isHidden = true
        selectedcoucesview_Height.constant = 0
        contentview_Height.constant = contentview_Height.constant - 340
        

         applyShadowOnView(selected_View)
        applyShadowOnView(courses_Table)
        applyShadowOnView(Choosecourse_View)
        applyShadowOnView(creditcard_View)
        applyShadowOnView(debitcard_View)
        applyShadowOnView(internetbanking_View)
        applyShadowOnView(upwallet_View)
        applyShadowOnView(paynow_But)

        
        Searchservicecalling()
        homeServiceCalling()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func paymentoptionscolour() {
         
        debitcard_View.backgroundColor = UIColor.white
        creditcard_View.backgroundColor = UIColor.white
        internetbanking_View.backgroundColor = UIColor.white
        upwallet_View.backgroundColor = UIColor.white
    }
    
    @IBAction func backButtonAction(_ sender: Any)
    {
   
   
   if from == "notifi" {
       
     let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
      let tab = storyBoard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
      tab.selectedIndex = 0
      self.navigationController?.pushViewController(tab, animated: true)
           
           
    } else {

    let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
    let tab = storyBoard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
    tab.selectedIndex = 0
    //[rev pushFrontViewController:tab animated:true];
    self.navigationController?.pushViewController(tab, animated: true)
         //self.navigationController?.popViewController(animated: true)
    }
    }
    @IBAction func whatsAppAction(_ sender: Any) {
       
        ActivityServiceCalling(Pagename: "RegisterCourse", Activity: "Chat")
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
      
        ActivityServiceCalling(Pagename: "RegisterCourse", Activity: "Search")
        
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
    
    @IBAction func creditcard_Action(_ sender: Any) {
        Paymentselected = true
        ActivityServiceCalling(Pagename: "RegisterCourse", Activity: "Creditcard")
       paymentoptionscolour()
       creditcard_View.backgroundColor = UIColor(red: 237.0/255.0, green: 68.0/255.0, blue: 112.0/255.0, alpha: 1.0)
        creditCardImage.image = UIImage(named:"Active_creditcard")
        debitCardImage.image = UIImage(named:"InActive_debitcard")
        bankingImage.image = UIImage(named:"InActive_internetbanking")
        walletImage.image = UIImage(named:"InActive_upiwallet")
        
    }
    
    @IBAction func debitcard_Action(_ sender: Any) {
      
        Paymentselected = true
     ActivityServiceCalling(Pagename: "RegisterCourse", Activity: "debitcard")
      paymentoptionscolour()
        debitcard_View.backgroundColor = UIColor(red: 237.0/255.0, green: 68.0/255.0, blue: 112.0/255.0, alpha: 1.0)
        debitCardImage.image = UIImage(named:"Active_debitcard")
        
        creditCardImage.image = UIImage(named:"InActive_creditcard")
        bankingImage.image = UIImage(named:"InActive_internetbanking")
        walletImage.image = UIImage(named:"InActive_upiwallet")
        
    }
    
    @IBAction func internet_Action(_ sender: Any) {
       Paymentselected = true
      ActivityServiceCalling(Pagename: "RegisterCourse", Activity: "Internetbanking")
      paymentoptionscolour()
      internetbanking_View.backgroundColor = UIColor(red: 237.0/255.0, green: 68.0/255.0, blue: 112.0/255.0, alpha: 1.0)
        bankingImage.image = UIImage(named:"Active_internetbanking")
        debitCardImage.image = UIImage(named:"InActive_debitcard")
        creditCardImage.image = UIImage(named:"InActive_creditcard")
        walletImage.image = UIImage(named:"InActive_upiwallet")
        
    }
    
    @IBAction func upwallet_Action(_ sender: Any) {
      Paymentselected = true
     ActivityServiceCalling(Pagename: "RegisterCourse", Activity: "UPI/WALLETS")
     paymentoptionscolour()
     upwallet_View.backgroundColor = UIColor(red: 237.0/255.0, green: 68.0/255.0, blue: 112.0/255.0, alpha: 1.0)
        walletImage.image = UIImage(named:"Active_upiwallet")
        bankingImage.image = UIImage(named:"InActive_internetbanking")
        debitCardImage.image = UIImage(named:"InActive_debitcard")
        creditCardImage.image = UIImage(named:"InActive_creditcard")
        
    }
    
    @IBAction func choosecourse_Action(_sender: UIButton) {
       
        ActivityServiceCalling(Pagename: "RegisterCourse", Activity: "ChooseCourse")
        if courses_Table.isHidden == true {
       
        choosecourse_img.image = UIImage(named: "Up_Arrow")
        courses_Table.isHidden = false
        selected_View.isHidden = true
        selectedcoucesview_Height.constant = 0
        table_Height.constant = CGFloat(courseDetailsData.count*50)
        contentview_Height.constant = 660 + table_Height.constant
            
            
        }
        else {
     
        choosecourse_img.image = UIImage(named: "Down_Arrow")
        courses_Table.isHidden = true
        table_Height.constant = 0
        contentview_Height.constant = 660 + table_Height.constant
            
        }
   
  
    }
    
    func homeServiceCalling() {

        if Reachability.isConnectedToNetwork(){


        let Urlname = "\(ConstantsKeys.AppLinks.BaseUrl)\(ConstantsKeys.AppGetUrls.home)"

        let params  = ["metadata": ["appname":"Hamstech", "apikey": "dsf99898398i3jofklese93","page": "hamstech_home_page","lang":"en"] ] as [String : Any]


        ActivityIndicatorWithLabel.shared.showProgressView(uiView: view)
        NetworkHelper.sharedInstance.postServiceCall(url: Urlname, PostDetails: params as [String : AnyObject]) { (response, error) in
        ActivityIndicatorWithLabel.shared.hideProgressView()

        let status:String =  String(response["status"] as! String)

        if status == "ok"{

        self.courseDetailsData.removeAll()


        if let courseDataArray = response["course_details"] as? [[String: Any]] {

        for list in courseDataArray {
        let courseObject = courseDetailsDataResponseModel(data: list as NSDictionary)
        self.courseDetailsData.append(courseObject)
        self.sectionIsExpanded.append(false)
            
        }
        self.courses_Table.reloadData()

        }
          
       

       // self.table_Height.constant = CGFloat(self.courseDetailsData.count) * 60 + 55
        //  self.mainview_Height.constant = 2400 + self.courses_Height.constant

        // hamstechview_Height

        print("self.courseDetailsData.count", self.courseDetailsData.count)


        }else {


        self.courseDetailsData.removeAll()

        self.courses_Table.reloadData()



        self.view.window?.makeToast(response["message"] as? String, duration: 2.0, position: CSToastPositionCenter)
        }
        }
        }
        else
        {
        self.customPresentAlert(withTitle: "", message: "Please Check Network Connection")
        }
        
   }

    
    func Searchservicecalling(){

        if Reachability.isConnectedToNetwork(){

            
        let Urlname = "\(ConstantsKeys.AppLinks.BaseUrl)\(ConstantsKeys.AppGetUrls.get_search)"

                
             
    let params  = ["metadata":["appname":"Hamstech","page":"search","apikey":"dsf99898398i3jofklese93"]]
              
                
         //  ActivityIndicatorWithLabel.shared.showProgressView(uiView: view)
             NetworkHelper.sharedInstance.postServiceCall(url: Urlname, PostDetails: params as [String : AnyObject]) { (response, error) in
           //  ActivityIndicatorWithLabel.shared.hideProgressView()
                 
             let status:String =  String(response["status"] as! String)

                if status == "ok"{

                    self.SearchistingData.removeAll()
                    if let dataArrya = response["course_list"] as? [[String: Any]] {
                        
                      print("dataArrya:", dataArrya)
                        
                        
                    for list in dataArrya {
                    let object = SearchResponseModel(data: list as NSDictionary)
                    self.SearchistingData.append(object)
                        
                    }
                    
                        
                 
                    
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

    
    func numberOfSections(in tableView: UITableView) -> Int {
            return courseDetailsData.count
            
        }
        
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // First will always be header

       //return sectionIsExpanded.count // static data
       
    return sectionIsExpanded[section] ? (1+registerData.count) : 1
    
   }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if indexPath.row == 0 {
                let cell = courses_Table.dequeueReusableCell(withIdentifier: headerIdentifier, for: indexPath) as! RegistercoursesCell
                cell.courses_Lbl.text = courseDetailsData[indexPath.section].categoryname
                cell.selectionStyle = .none
                cell.selsect_But.tag = indexPath.section
                
                if sectionIsExpanded[indexPath.section] == false {
                    
                    cell.arrrow_Img.image = UIImage(named: "Up_Arrow")
                    
                } else {
                    
                 cell.arrrow_Img.image = UIImage(named: "Down_Arrow")
                    
                }
                
    
                return cell
            } else {
                let cell = courses_Table.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RegisterSubcoursesCell

                
                cell.subcourse_Lbl.text = registerData[indexPath.row-1]
        
                
                return cell
            }
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            
            if indexPath.row == 0 {
                
                return 50
                
            } else {
            return UITableView.automaticDimension
            
    }
          }
        
    
    // Expand&Collapes Tableview
    
 func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    

    print("SearchistingData.count", SearchistingData.count)
    print("courseDetailsData.count", courseDetailsData.count)
    
   
    
        if indexPath.row == 0 {

            catname = courseDetailsData[indexPath.section].categoryname
            
            registerData.removeAll()
            registerimageData.removeAll()
            registerprizeData.removeAll()
            
            for i in 0..<SearchistingData.count {

                let searchid = SearchistingData[i].categoryId
                let courseid = courseDetailsData[indexPath.section].categoryId
               
                
                let courcename = SearchistingData[i].course_name
                let image = SearchistingData[i].image_url
                let prize = SearchistingData[i].amount
                let courid = SearchistingData[i].courseId
                
                if searchid == courseid {
                    
                    registerid.append(courid!)
                    registerData.append(courcename!)
                    registerimageData.append(image!)
                    registerprizeData.append(prize!)
                    
                }
                
                
            }

            
        if sectionIsExpanded[indexPath.section] == false {

        self.sectionIsExpanded.removeAll()

        for _ in 0..<courseDetailsData.count {

        self.sectionIsExpanded.append(false)

        }

        courses_Table.reloadData()

        sectionIsExpanded[indexPath.section] = !sectionIsExpanded[indexPath.section]
        // courses_Table.sectionIndexColor = UIColor.black
        courses_Table.reloadSections([indexPath.section], with: .none)

        table_Height.constant = CGFloat(courseDetailsData.count*50) + CGFloat(registerData.count*50) + 10
        contentview_Height.constant = 660 + table_Height.constant


        } else {

        self.sectionIsExpanded.removeAll()

        for _ in 0..<courseDetailsData.count {

        self.sectionIsExpanded.append(false)



        }

      
            
        courses_Table.reloadData()

        table_Height.constant = CGFloat(courseDetailsData.count*50) + 10
        contentview_Height.constant = 660 + table_Height.constant


        print("true")

        }




        }
    
        else {
            
       ActivityServiceCalling(Pagename: "RegisterCourse", Activity: "CourseSelected")
       table_Height.constant = 0
       selectedcoucesview_Height.constant = 140
       contentview_Height.constant = 615 + table_Height.constant + selectedcoucesview_Height.constant
       
       chooseoption_Height.constant = 0
       Choosecourse_View.isHidden = true
       selected_View.isHidden = false
       courses_Table.isHidden = true
       choosecourse_img.image = UIImage(named: "Down_Arrow")
            
            
            
        catname_Lbl.text = catname
        courcename_Lbl.text = registerData[indexPath.row-1]
        cource_Img.setKFImage(with: registerimageData[indexPath.row-1])
      //  selected_Img.setKFImage(with: registerimageData[indexPath.row-1])
        price = registerprizeData[indexPath.row-1]
        pricedescription_Lbl.text = " Get Scholarships and disconts by registering now for a refundable amount of Rs. \(price)/- and confirm your admission."
            
        courseselected = true
            
        let courid = registerid[indexPath.row-1]
        UserDefaults.standard.set(price, forKey: "prize")
        UserDefaults.standard.set(courid, forKey: "courseid")
            
            
       }
    
    
    
    
    }
    
    // Select Course
    
    @IBAction func expand_But(_ sender: UIButton) {
    
       
  
    }
    
    // unSelect Course
    
    @IBAction func unselelect_Action(_ sender: Any) {
        
        courseselected = false
        ActivityServiceCalling(Pagename: "RegisterCourse", Activity: "Courseunselected")
        table_Height.constant = 0
        courses_Table.isHidden = true
        selected_View.isHidden = true
        selectedcoucesview_Height.constant = 0
        contentview_Height.constant = 660
        chooseoption_Height.constant = 45
        Choosecourse_View.isHidden = false
        
    }
    
    
    @IBAction func paynow_Action(_ sender: Any) {
        
        if courseselected == false {
            self.customPresentAlert(withTitle: "", message: "Please Choose Your Course")
            
        } else if Paymentselected == false {
           self.customPresentAlert(withTitle: "", message: "Please Choose Your Payment Method")
            
        } else {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RegisterbasicDetailsViewController") as? RegisterbasicDetailsViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
  
}
