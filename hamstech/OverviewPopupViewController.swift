//
//  OverviewPopupViewController.swift
//  hamstech
//
//  Created by Priyanka on 14/07/20.
//

import UIKit

class OverviewPopupViewController: UIViewController {

    @IBOutlet weak var overview_Lbl: UILabel!
    @IBOutlet weak var main_View: UIView!
    
    var overviewtxt = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        overview_Lbl.text = overviewtxt
        
         main_View.layer.cornerRadius = 15
        // Do any additional setup after loading the view.
    }
   
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func close_Action(_ sender: Any) {
        
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
