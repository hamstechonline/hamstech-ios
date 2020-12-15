//
//  NotificationPopupViewController.swift
//  hamstech
//
//  Created by Priyanka on 04/06/20.
//

import UIKit

class NotificationPopupViewController: UIViewController {

    @IBOutlet weak var notifi_Img: UIImageView!
    @IBOutlet weak var notifititle_Txt: UILabel!
    @IBOutlet weak var notificationtext_Lbl: UILabel!
    @IBOutlet weak var content_View: UIView!
    
    
    var index = Int()
    var Titletxt = String()
    var text = String()
    var Img = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        notifi_Img.setKFImage(with: Img)
        notifititle_Txt.text = Titletxt
        notificationtext_Lbl.text = text
        notifi_Img.layer.cornerRadius = 10
        notifi_Img.clipsToBounds = true
        applyShadowOnView(content_View)
        if (index % 2) == 1 {
            // odd
            
            notifititle_Txt.textColor = UIColor.darkGray
            //notifi_Img.backgroundColor = UIColor.darkGray
            notifi_Img.image = UIImage(named:"Notification_Grey")
           
            
        } else {
            // even
            
            notifititle_Txt.textColor = UIColor(red: 237.0/255.0, green: 68.0/255.0, blue: 112.0/255.0, alpha: 0.5)
                       // notifi_Img.backgroundColor = UIColor(red: 237.0/255.0, green: 68.0/255.0, blue: 112.0/255.0, alpha: 0.5)
             notifi_Img.image = UIImage(named:"Notification_Pink")
           
            
            
        }
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func dissmiss_Action(_ sender: Any) {
        
        
        self.dismiss(animated: false, completion: nil)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
