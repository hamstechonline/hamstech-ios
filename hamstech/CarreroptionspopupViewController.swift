//
//  CarreroptionspopupViewController.swift
//  hamstech
//
//  Created by Priyanka on 14/07/20.
//

import UIKit

class CarreroptionspopupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   
    
    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var main_View: UIView!
    @IBOutlet weak var carrer_Table: UITableView!
    
     var courseCareerOptionData  =  [careerOptionsDataResponseModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        carrer_Table.separatorStyle = .none
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissView))
//        view.addGestureRecognizer(tapGesture)
        
        main_View.layer.cornerRadius = 15
       
       
        applyShadowOnView(carrer_Table)
        
        // Do any additional setup after loading the view.
    }
    
//    override func updateViewConstraints() {
//
//        height.constant = carrer_Table.contentSize.height
//        super.updateViewConstraints()
//    }
    
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        height.constant = carrer_Table.contentSize.height + 55
    }
    
    @IBAction func dismiss_Action(_ sender: Any) {
        
          self.dismiss(animated: false, completion: nil)
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return courseCareerOptionData.count
        
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = carrer_Table.dequeueReusableCell(withIdentifier: "CarreroptionsPopupCell", for: indexPath) as! CarreroptionsPopupCell
        
        cell.carreroption_Lbl.text = courseCareerOptionData[indexPath.row].careerOptions ?? ""
        
        return cell
       }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
}
