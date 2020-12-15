//
//  WelcomeViewController.swift
//  hamstech
//
//  Created by Priyanka on 24/05/20.
//

import UIKit

class WelcomeViewController: UIViewController {
    @IBOutlet weak var name_Lbl: UILabel!
    
    var timer:Timer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ActivityServiceCalling(Pagename: "Welcomescreen", Activity: "Viewed")
        
        let prospectname: String = UserDefaults.standard.object(forKey: "prospectname") as? String ?? ""
        
        name_Lbl.text = prospectname
        self.timer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector:  #selector(WelcomeViewController.OfterDuration), userInfo: nil, repeats: false)
    }
    

       @objc func OfterDuration(){
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }

}
