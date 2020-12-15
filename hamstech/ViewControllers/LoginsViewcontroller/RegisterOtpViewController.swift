//
//  RegisterOtpViewController.swift
//  hamstech
//
//  Created by Priyanka on 28/04/20.
//

import UIKit

class RegisterOtpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
  ActivityServiceCalling(Pagename: "Register", Activity: "Viewed")
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }

    @IBAction func getOtpButtonAction(_ sender: Any) {
        
        
        if nameTextField.text == "" {
           
            self.customPresentAlert(withTitle: "", message: "Please enter Your Name")
            
        } else if !isValidPhone(phone: mobileTextField.text ?? "")  {
            
            self.customPresentAlert(withTitle: "", message: "Please enter Valid Mobile Number")
            
        } else {
     
             ActivityServiceCalling(Pagename: "Register", Activity: "getotp")
            RegisterServiceCalling()
            
       
        }
    }
    
    @IBAction func signInButtonAction(_ sender: Any) {
 
         ActivityServiceCalling(Pagename: "Register", Activity: "signinclicked")
 
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginOtpViewController") as? LoginOtpViewController
        self.navigationController?.pushViewController(vc!, animated: true)
               
    }
    
    func RegisterServiceCalling() {
                  
                  if Reachability.isConnectedToNetwork(){
                  let Urlname =  "\(ConstantsKeys.AppLinks.BaseUrl)\(ConstantsKeys.AppGetUrls.getotp)"
                   
                   
                   let params  = ["page":"registration","phone":mobileTextField.text!,"countrycode":"91","lang":ConstantsKeys.apikey.lan] as [String : Any]
            
                   ActivityIndicatorWithLabel.shared.showProgressView(uiView: view)
                  NetworkHelper.sharedInstance.postServiceCall(url: Urlname, PostDetails: params as [String : AnyObject]) { (response, error)  in

                  ActivityIndicatorWithLabel.shared.hideProgressView()

                   if let status = response["status"] as? NSDictionary {
                    let message = status["message"] as! NSDictionary
                    
                     let responsecode:String =   String(message["responsecode"] as! String)
                   
                    
                    print(responsecode)
                    
                    if responsecode == "OK" {
                     
                    let loginResponseData = LoginResponseModel (data: status["metadata"] as! NSDictionary)

                    let otphash = loginResponseData.otphash
                        
                      let metadata = status["metadata"] as! NSDictionary
                     let otptimestamp = metadata["timestamp"] as! NSNumber

                    UserDefaults.standard.set(otphash, forKey: "otphash")
                    UserDefaults.standard.set(otptimestamp, forKey: "otptimestamp")
                        
                        
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RegisterVerifyViewController") as? RegisterVerifyViewController
                        vc?.name = self.nameTextField.text!
                        vc?.number = self.mobileTextField.text!
                    self.navigationController?.pushViewController(vc!, animated: true)
                   
                        
                        
                    } else {
                      
                       
                        
                        let data = status["data"] as! NSString
                       // let loginResponseData = LoginResponseModel (data: status["data"] as! NSDictionary)
                       // let response = loginResponseData.response

                        self.customPresentAlert(withTitle: "", message: (data) as String)
                    }
                   } else {
                    
                    
                    if let status = response["status"] as? String {
                       
                         self.customPresentAlert(withTitle: "", message: (status) as String)
                        
                    }
                    
                    }
                   
                  }

                  }
           
                  else
                  {
                      self.customPresentAlert(withTitle: "", message: "Please Check Network Connection")
                  }
              }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,replacementString string: String) -> Bool{
           
           
           let allowedCharacters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
           let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
           let typedCharacterSet = CharacterSet(charactersIn: string)
           let alphabet = allowedCharacterSet.isSuperset(of: typedCharacterSet)
        
           return alphabet
       }
    
    
}
