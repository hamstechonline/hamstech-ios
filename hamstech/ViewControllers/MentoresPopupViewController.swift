//
//  MentoresPopupViewController.swift
//  hamstech
//
//  Created by Priyanka on 04/06/20.
//

import UIKit

class MentoresPopupViewController: UIViewController {

    @IBOutlet weak var mentor_Img: UIImageView!
    @IBOutlet weak var description_Lbl: UILabel!
    @IBOutlet weak var content_View: UIView!
    @IBOutlet weak var titile_Lbl: UILabel!
    
    
    var img = String()
    var Description = String()
    var Title = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titile_Lbl.text = Title
        description_Lbl.text = Description
        mentor_Img.setKFImage(with: img)
        applyShadowOnView(content_View)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func Dissmiss_Action(_ sender: Any) {
        
        self.dismiss(animated: false, completion: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
         self.navigationController?.navigationBar.isHidden = true
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
