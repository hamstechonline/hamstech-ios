//
//  ChatViewController.swift
//  hamstech
//
//  Created by Priyanka on 29/04/20.
//

import UIKit

class ChatViewController: UIViewController {

    
    var checking : Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
             self.navigationController?.navigationBar.isHidden = true
            UserDefaults.standard.set(true, forKey: "checked")
                  self.openWhatsapp()
        
        
         }
    
    
    //Whats app
    func openWhatsapp(){
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
    
 
    
    override func viewWillDisappear(_ animated: Bool) {
        UserDefaults.standard.set(false, forKey: "checked")
    }
    

    
    
}

