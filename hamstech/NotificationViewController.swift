//
//  NotificationViewController.swift
//  hamstech
//
//  Created by Priyanka on 15/05/20.
//

import UIKit
import SideMenu

class NotificationViewController: UIViewController {
    
    @IBOutlet weak var notificationTableView: UITableView!
    
    var NotificationListingData = [NotificationdataResponseModel]()
    var from = String()
    var Titletxt = String()
    var text = String()
    var Img = String()
    
     var timer:Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

 
        
        
        ActivityServiceCalling(Pagename: "Notification", Activity: "View")
        // Do any additional setup after loading the view.
        self.NotificationServiceCalling()
        
        

   self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(NotificationViewController.auto), userInfo: nil, repeats: false)
        
    }
    
        @objc func auto() {

            DispatchQueue.main.async {
                
                if self.from == "notifi" {
            
                    
                 let story = UIStoryboard.init(name: "Main", bundle: nil)
                     let cartVC = story.instantiateViewController(withIdentifier: "NotificationPopupViewController") as! NotificationPopupViewController
                     cartVC.Titletxt = self.Titletxt
                     cartVC.index = 1
                    cartVC.Img = self.Img
                     cartVC.text = self.text
                     var viewcontroller = UIApplication.shared.keyWindow?.rootViewController
                     let navigation = UINavigationController.init(rootViewController: cartVC)
                     navigation.modalPresentationStyle = .overCurrentContext
                     while ((viewcontroller?.presentedViewController) != nil){
                     viewcontroller = viewcontroller?.presentedViewController
                     }
                     viewcontroller?.present(navigation, animated: false, completion: nil)
                }
                         
                 }
  

   
            
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
          self.navigationController?.navigationBar.isHidden = true
      }
  
    
    
    @IBAction func whatsAppAction(_ sender: Any) {
       
        ActivityServiceCalling(Pagename: "Notification", Activity: "Chat")
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
      
        ActivityServiceCalling(Pagename: "Notification", Activity: "Search")
        
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
    
    if from == "notifi" {
        
      let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
       let tab = storyBoard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
       tab.selectedIndex = 0
       self.navigationController?.pushViewController(tab, animated: true)
        
        
    } else {
    
    _ = self.navigationController?.popViewController(animated: true)
        
    }
        
    }
    
    // servicecall
       func NotificationServiceCalling() {

           if Reachability.isConnectedToNetwork(){

           //email,password,device_type,device_token

               let Urlname = "\(ConstantsKeys.AppLinks.BaseUrl)\(ConstantsKeys.AppGetUrls.Notifications)"

               let params  = ["metadata": ["appname":ConstantsKeys.apikey.appname, "apikey": ConstantsKeys.apikey.api_key,"page": "notification","lang":ConstantsKeys.apikey.lan] ] as [String : Any]

           
            ActivityIndicatorWithLabel.shared.showProgressView(uiView: view)
           NetworkHelper.sharedInstance.postServiceCall(url: Urlname, PostDetails: params as [String : AnyObject]) { (response, error) in
          ActivityIndicatorWithLabel.shared.hideProgressView()
               
           let status:String =  String(response["status"] as! String)

               
           if status == "ok"{
               
           self.NotificationListingData.removeAll()
           if let dataArrya = response["list"] as? [[String: Any]] {
           for list in dataArrya {
           let object = NotificationdataResponseModel(data: list as NSDictionary)
           self.NotificationListingData.append(object)
           }
               
           self.notificationTableView.reloadData()
               
           }
            
           }else {
               
             self.NotificationListingData.removeAll()
             self.notificationTableView.reloadData()
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
extension NotificationViewController:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
            
           }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
              
            return NotificationListingData.count
           }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = notificationTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! N_TableViewCell
            
            cell.notificationImage.setKFImage(with: NotificationListingData[indexPath.row].notification_image)
            cell.notificationTitle.text = NotificationListingData[indexPath.row].notification_title
            cell.notificationDescription.text = NotificationListingData[indexPath.row].notification_description
            
             cell.notificationImage.layer.cornerRadius = 6
             cell.notificationImage.clipsToBounds = true
            cell.back_View.layer.cornerRadius = 6
            cell.back_View.clipsToBounds = true
            
        
            
            if (indexPath.row % 2) == 1 {
                // odd
                cell.back_View.backgroundColor = UIColor(red: 232.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1.0)
                cell.notificationTitle.textColor = UIColor.darkGray
                //cell.notificationImage.backgroundColor = UIColor.darkGray
                cell.notificationImage.image = UIImage(named:"Notification_Grey")
                
                
            } else {
                // even
                
                
                cell.back_View.backgroundColor = UIColor.white
                cell.notificationTitle.textColor = UIColor(red: 237.0/255.0, green: 68.0/255.0, blue: 112.0/255.0, alpha: 0.5)
               // cell.notificationImage.backgroundColor = UIColor(red: 237.0/255.0, green: 68.0/255.0, blue: 112.0/255.0, alpha: 0.5)
                cell.notificationImage.image = UIImage(named:"Notification_Pink")
                
                
                
            }
            
            
                    return cell
           }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 130
      }
    
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        ActivityServiceCalling(Pagename: "Notification", Activity: "Viewed")
       
        
    let story = UIStoryboard.init(name: "Main", bundle: nil)
        let cartVC = story.instantiateViewController(withIdentifier: "NotificationPopupViewController") as! NotificationPopupViewController
        cartVC.Titletxt = NotificationListingData[indexPath.row].notification_title ?? ""
        cartVC.index = indexPath.row
        cartVC.text = NotificationListingData[indexPath.row].notification_description ?? ""
        var viewcontroller = UIApplication.shared.keyWindow?.rootViewController
        let navigation = UINavigationController.init(rootViewController: cartVC)
        navigation.modalPresentationStyle = .overCurrentContext
        while ((viewcontroller?.presentedViewController) != nil){
        viewcontroller = viewcontroller?.presentedViewController
        }
        viewcontroller?.present(navigation, animated: false, completion: nil)
        
    
            
            
    }
            
}
