//
//  RegisterbasicDetailsViewController.swift
//  hamstech
//
//  Created by Priyanka on 26/05/20.
//

import UIKit
import SideMenu

class RegisterbasicDetailsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var back_View: UIView!
    @IBOutlet weak var submit_But: UIButton!
    @IBOutlet weak var dropdown_Img: UIImageView!
    @IBOutlet weak var dropdown_Table: UITableView!
    
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var phoneNumber: UITextField!
    
    @IBOutlet weak var address: UITextField!
    
    @IBOutlet weak var locality: UITextField!
    
    @IBOutlet weak var city: UITextField!
    
    @IBOutlet weak var state: UITextField!
    
    @IBOutlet weak var pincode: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
         ActivityServiceCalling(Pagename: "BasicDetails", Activity: "Viewed")
        
        
              let phonenumber: String = UserDefaults.standard.object(forKey: "phonenumber") as? String ?? ""
        phoneNumber.text = phonenumber
        
   applyShadowOnView(back_View)
   applyShadowOnView(submit_But)
        firstName.delegate = self
        lastName.delegate = self
        
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func backButtonAction(_ sender: Any)
    {
         self.navigationController?.popViewController(animated: true)
    }
    @IBAction func whatsAppAction(_ sender: Any) {
       
       ActivityServiceCalling(Pagename: "BasicDetails", Activity: "Chat")
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
      
        ActivityServiceCalling(Pagename: "BasicDetails", Activity: "Search")
        
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
    
    @IBAction func dropdown_Action(_ sender: Any) {
        
//        if dropdown_Table.isHidden == true {
//
//            dropdown_Table.isHidden = false
//
//        } else {
//
//          dropdown_Table.isHidden = true
//
//        }
        
        
        
    }
    
    
    @IBAction func submitButtonAction(_ sender: Any) {
        
        ActivityServiceCalling(Pagename: "BasicDetails", Activity: "Submit")
        
          if firstName.text == "" {

                           self.customPresentAlert(withTitle: "", message: "Please enter First Name")

                       } else if lastName.text == ""
                       {
                            self.customPresentAlert(withTitle: "", message: "Please enter Last Name")

                       } else if !isValidemail(emailAddress: email.text ?? "") {

                           self.customPresentAlert(withTitle: "", message: "Please enter Valid Email Id")

                       } else if !isValidPhone(phone: phoneNumber.text ?? "")  {

                           self.customPresentAlert(withTitle: "", message: "Please enter Valid Phone Number")

                       }else if address.text == ""  {

                           self.customPresentAlert(withTitle: "", message: "Please enter Valid Address")

                       }else if locality.text == ""  {

                           self.customPresentAlert(withTitle: "", message: "Please enter Locality/District")

                       }else if city.text == ""  {

                           self.customPresentAlert(withTitle: "", message: "Please enter City/Town")

                       }else if state.text == ""  {

                           self.customPresentAlert(withTitle: "", message: "Please enter Valid State")

                       }else if !isValidPinCode(Indiapincode: pincode.text ?? "") {

                           self.customPresentAlert(withTitle: "", message: "Please enter Valid Pincode")

                       } else {


                        self.passingPaymentDetails()

                       }
                      }
            
            func passingPaymentDetails()
            {
                //MARK:: OrderId Generation
                let randomNumber = (arc4random() % 9999999) + 1
                let randomString = String(randomNumber)
                
                 let controller:CCWebViewController = CCWebViewController()
                
                 controller.accessCode = "AVVS92HF95BT57SVTB"
                 controller.merchantId = "258349"
                
                let amount = UserDefaults.standard.string(forKey: "prize") ?? ""
                let courseid = UserDefaults.standard.string(forKey: "courseid") ?? ""
                
                  //controller.amount = amount
                  controller.amount = "1.0"
                  controller.currency = "INR"
                  controller.orderId = randomString
                  controller.selectedCourseId = courseid
                
                
        
                controller.redirectUrl = "http://app.hamstech.com/qc/api/list/ios_transactions/"
                controller.cancelUrl = "http://app.hamstech.com/qc/api/list/ios_transactions/"
                controller.rsaKeyUrl = "http://app.hamstech.com/qc/rsa-handling-ccavenue/GetRSA.php"
         
                  controller.billing_FirstName = firstName.text!
                  controller.billing_LastName = lastName.text!
                  controller.billing_Email = email.text!
                  controller.billing_Phone = phoneNumber.text!
                  controller.billing_Address = address.text!
                  controller.billing_Locality = locality.text!
                  controller.billing_City = city.text!
                  controller.billing_State = state.text!
                  controller.billing_Pincode = pincode.text!
                 self.navigationController?.pushViewController(controller, animated: true)
                
                  //self.present(controller, animated: true, completion: nil)
                
               // let vc = CCWebViewController()
              //  self.navigationController?.pushViewController(vc, animated: true)
                
                // let vc = CCWebViewController()
               //  self.navigationController?.pushViewController(vc, animated: true)
//                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CCWebViewController") as? CCWebViewController
//                self.navigationController?.pushViewController(vc!, animated: true)
                
                
//                let storyboard = UIStoryboard(name:"Main", bundle: nil)
//                    let myAppoint = storyboard.instantiateViewController(withIdentifier: "CCWebViewController") as? CCWebViewController
                   // myAppoint?.from = "notifi"
                
                   
                
                   
                
                
            }
    }
    



extension RegisterbasicDetailsViewController: UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = dropdown_Table.dequeueReusableCell(withIdentifier: "StatedropdownCell", for: indexPath) as! StatedropdownCell

                   
         return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,replacementString string: String) -> Bool{
            
            
            let allowedCharacters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
            let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
            let typedCharacterSet = CharacterSet(charactersIn: string)
            let alphabet = allowedCharacterSet.isSuperset(of: typedCharacterSet)
         
            return alphabet
        }
    
    
    
}
