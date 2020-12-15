//
//  SidemenuViewController.swift
//  hamstech
//
//  Created by Priyanka on 11/05/20.
//

import UIKit
import SDWebImage

class SidemenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var topview: UIView!
    @IBOutlet weak var user_View: UIView!
    @IBOutlet weak var user_Img: UIImageView!
    @IBOutlet weak var sidemenu_Table: UITableView!
   // @IBOutlet weak var table_Height: NSLayoutConstraint!
    @IBOutlet weak var tableback_View: UIView!
    @IBOutlet weak var name_Lbl: UILabel!
    @IBOutlet weak var number_Lbl: UILabel!
    
    private let headerIdentifier = "Cell"
    private let cellIdentifier = "Cell1"
    
     private var sectionIsExpanded =  [Bool]()
    
    var userimage = String()
    var usernsme = String()
    var mobilenumber = String()
    
    var sectionimage = ["Profile","Notification_Pink","collapsdown","LifeAtHamstech","OnlineCounselling","ChatWithUs","ContactUs","Register"]
    var sections = ["Profile","Notifictions","Hamstech Story","Life at Hamstech","Online Counselling","Chat with Us","Contact Us","Register"]
    var inner = ["About Us","Affliations","Mentors"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       // ProfileServiceCalling()
    }
    
        func ProfileServiceCalling() {

            if Reachability.isConnectedToNetwork(){

            let phonenumber: String = UserDefaults.standard.object(forKey: "phonenumber") as? String ?? ""

            let Urlname = "\(ConstantsKeys.AppLinks.BaseUrl)\(ConstantsKeys.AppGetUrls.getprofile)"

               // {"phone":"8056512411","page":"profile","apikey":"dsf99898398i3jofklese93"}
                
            let params  = ["phone": phonenumber, "apikey": ConstantsKeys.apikey.api_key,"page": "profile"]
               
               
               
        //   ActivityIndicatorWithLabel.shared.showProgressView(uiView: view)
                
            NetworkHelper.sharedInstance.postServiceCall(url: Urlname, PostDetails: params as [String : AnyObject]) { (response, error) in
                
         //   ActivityIndicatorWithLabel.shared.hideProgressView()
            
            let status = response["status"] as! NSDictionary
                
            let status1:Int =  Int(status["status"] as! Int)

                
            if status1 == 200{
         
            let loginResponseData = ProfileResponseModel (data: response["data"] as! NSDictionary)
      
                self.name_Lbl.text = loginResponseData.prospectname ?? ""
                self.number_Lbl.text = loginResponseData.phone ?? ""
                
                let image = loginResponseData.profilepic ?? ""
                self.user_Img.image = UIImage(url: URL(string:image))
                
// try this

        if let imageURL = URL.init(string: image) {

        SDImageCache.shared.removeImage(forKey: imageURL.absoluteString, withCompletion: nil)



        self.user_Img.sd_setImage(with: URL(string:image), placeholderImage: UIImage.init(named: "no-user-Img"), options: .highPriority, completed: { (img, imgerror, cachetype, imgur) in
        })
        }

                
      //  self.user_Img.image = UIImage(url: URL(string:image))
                
                
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
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
              //  table_Height.constant = 550
                
                for list in 0..<sections.count {
                    
                self.sectionIsExpanded.append(false)
            
                }
                
               // self.sidemenu_Table.clipsToBounds = true
                self.sidemenu_Table.layer.cornerRadius = 20
                
                if #available(iOS 11.0, *) {
                self.sidemenu_Table.layer.maskedCorners = [.layerMinXMaxYCorner]

                } else {
                // Fallback on earlier versions
                }
                
                sidemenu_Table.clipsToBounds = false
      
                user_View.layer.cornerRadius = user_View.frame.size.height/2
                user_Img.layer.cornerRadius = user_Img.frame.size.height/2
  
         let profilepic: String = UserDefaults.standard.object(forKey: "profilepic") as? String ?? ""
        let profilename: String = UserDefaults.standard.object(forKey: "prospectname") as? String ?? ""
        let profilenumber: String = UserDefaults.standard.object(forKey: "phonenumber") as? String ?? ""
        
        self.user_Img.sd_setImage(with: URL(string:profilepic), placeholderImage: UIImage.init(named: "profileImage"), options: .highPriority, completed: { (img, imgerror, cachetype, imgur) in
             })
        
                self.name_Lbl.text = profilename
                self.number_Lbl.text = profilenumber
//                 
//                self.user_Img.image = UIImage(url: URL(string:userimage))
              
        
           self.navigationController?.navigationBar.isHidden = true
        
      //  ProfileServiceCalling()
     }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
        
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           // First will always be header

           //return sectionIsExpanded.count // static data
           
        return sectionIsExpanded[section] ? (1+inner.count) : 1
       }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = sidemenu_Table.dequeueReusableCell(withIdentifier: headerIdentifier, for: indexPath) as! sidemenuTableViewCell
            
            cell.section_Lbl.text = sections[indexPath.section]
            cell.selectionStyle = .none
            
          
            cell.sidemenu_Img.image = UIImage(named: sectionimage[indexPath.section])
           
            
            if indexPath.section == 2 {
              
                cell.sidemenu_Img.image = UIImage(named: "pink_downarrow_slidebar")
                
            }
            
            if sectionIsExpanded[indexPath.section] == true {
                
                cell.backgroundColor = UIColor(red: 237.0/255.0, green: 68.0/255.0, blue: 112.0/255.0, alpha: 0.5)
                cell.section_Lbl.textColor = UIColor.white
                cell.sidemenu_Img.image = UIImage(named: "downarrow_slidebar")
                
            } else {
                
               cell.backgroundColor = UIColor.white
               cell.section_Lbl.textColor = UIColor.black
            }
            
            
            
            
           // cell.titleLabel.changeLabelAlignment()
            
//            if sectionIsExpanded[indexPath.section] {
//                cell.setExpanded()
//            } else {
//                cell.setCollapsed()
//            }
            return cell
        } else {
            let cell = sidemenu_Table.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! sidemenuTableViewCell1

            
            cell.expand_Lbl.text = inner[indexPath.row-1]
    
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 60
      }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // Expand/hide the section if tapped its header
            
            if indexPath.section == 0
            {
                DispatchQueue.main.async {
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController
                self.navigationController?.pushViewController(vc!, animated: true)
                }
            }
            if indexPath.section == 1
            {
                DispatchQueue.main.async {
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "NotificationViewController") as? NotificationViewController
                self.navigationController?.pushViewController(vc!, animated: true)
                }
            }
            
            if indexPath.section == 2 {
            
            if indexPath.row == 0  {
                
             

                if self.sectionIsExpanded[indexPath.section] == false {

                   self.sectionIsExpanded.removeAll()

                    for _ in 0..<self.sections.count {

                   self.sectionIsExpanded.append(false)

                   }

                    self.sidemenu_Table.reloadData()

                    self.sectionIsExpanded[indexPath.section] = !self.sectionIsExpanded[indexPath.section]
                   // courses_Table.sectionIndexColor = UIColor.black
                    self.sidemenu_Table.reloadSections([indexPath.section], with: .none)

                   // table_height.constant = CGFloat(Categorydata.count*65) + CGFloat(Categorydata[indexPath.section].sub_id.count*65) + 50
                  


                   } else {

                   self.sectionIsExpanded.removeAll()

                    for _ in 0..<self.sections.count {

                   self.sectionIsExpanded.append(false)



                   }

                    self.sidemenu_Table.reloadData()

                  // sidemenu_Table.constant = CGFloat(Categorydata.count*65) + 50
                

                   }




     //              }
                
                
    //            sectionIsExpanded[indexPath.section] = !sectionIsExpanded[indexPath.section]
    //            tableView.sectionIndexColor = UIColor.black
    //            tableView.reloadSections([indexPath.section], with: .automatic)
                
               // table_Height.constant = 730
               
               
                }
                if indexPath.row == 1 {
                    
                 // table_Height.constant = 550
                    DispatchQueue.main.async {
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AboutUsViewController") as? AboutUsViewController
                self.navigationController?.pushViewController(vc!, animated: true)
                    
//                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AboutUsViewController") as? AboutUsViewController
//                    self.tabBarController?.selectedIndex = 1
//                self.navigationController?.pushViewController(vc!, animated: true)
                    }
                    
            }
            if indexPath.row == 2  {
                DispatchQueue.main.async {
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AffliationsViewController") as? AffliationsViewController
                self.navigationController?.pushViewController(vc!, animated: true)
                }
            }
            if indexPath.row == 3  {
                DispatchQueue.main.async {
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MentorsViewController") as? MentorsViewController
                self.navigationController?.pushViewController(vc!, animated: true)
                }
                
            }
                
                sidemenu_Table.reloadSections([indexPath.section], with: .none)
                sidemenu_Table.reloadData()
                           
                
        }
        if indexPath.section == 3
        {
            
            DispatchQueue.main.async {
           let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LifeAtHamstechViewController") as? LifeAtHamstechViewController
            self.navigationController?.pushViewController(vc!, animated: true)
            }
        }
        if indexPath.section == 4
        {
//            let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
//                   let tab = storyBoard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
//                   tab.selectedIndex = 2
//                   //[rev pushFrontViewController:tab animated:true];
//                   self.navigationController?.pushViewController(tab, animated: true)
         
            DispatchQueue.main.async {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CounsellingViewController") as? CounsellingViewController
            vc?.fromsidemenu = true
        self.navigationController?.pushViewController(vc!, animated: true)

            }
            
        }
//        if indexPath.section == 5
//        {
//
//
//        
//        }
        if indexPath.section == 5
        {
            DispatchQueue.main.async {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController
            self.navigationController?.pushViewController(vc!, animated: true)
            }
            
        }
        if indexPath.section == 6
        {
            
//            let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
//            let tab = storyBoard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
//            tab.selectedIndex = 4
//           // tab.selectedIndex = 5
//            //[rev pushFrontViewController:tab animated:true];
//            self.navigationController?.pushViewController(tab, animated: true)
            
            DispatchQueue.main.async {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ContactUsViewController") as? ContactUsViewController
               vc?.fromsidemenu = true
                self.navigationController?.pushViewController(vc!, animated: true)
            }
        }
        if indexPath.section == 7
        {
                DispatchQueue.main.async {
         let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController
         self.navigationController?.pushViewController(vc!, animated: true)
            
            }
        }
    }

}

extension UIView {
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
    let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    self.layer.mask = mask
  }
}
