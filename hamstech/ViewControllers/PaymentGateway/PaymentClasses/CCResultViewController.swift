//
//  CCResultViewController.swift
//  CCIntegrationKit_Swift
//


import UIKit

class CCResultViewController: UIViewController {

    var transStatus = String()
    
    
//    let resultLable: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textAlignment = .center
//        label.numberOfLines = 0
//        return label
//    }()
//
//    lazy var homeBtn: UIButton = {
//
//        let button = UIButton()
//        button.backgroundColor = UIColor.orange
//        button.layer.borderWidth = 1
//        button.layer.borderColor = UIColor.orange.cgColor
//        button.layer.cornerRadius = 5.0
//        button.layer.masksToBounds = true
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("  Go Back To Home Page  ", for: .normal)
//        button.addTarget(self, action: #selector(goToHomeClick), for: .touchUpInside)
//        return button
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        print(transStatus)
        self.navigationController?.navigationBar.isHidden = true
        
//        self.view.addSubview(resultLable)
//        self.view.addSubview(homeBtn)
//        resultLable.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
//        resultLable.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
//        homeBtn.topAnchor.constraint(equalTo: self.resultLable.bottomAnchor, constant: 20).isActive = true
//        homeBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
//        homeBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        self.resultLable.text = transStatus
//        self.resultLable.reloadInputViews()
        
        
        
        
            if self.transStatus == "Transaction Successful" {

            self.result(gifname:"full-success-size1234")
        
                
           } else if self.transStatus == "Transaction Failed"  {

            self.result(gifname:"final-error-full-size1_123")
                   
                
            } else {
                
               self.result(gifname:"final-error-full-size1_123")
        }
          
    

    }
    
//    @objc fileprivate func goToHomeClick(sender:UIButton){
//
//        let controller: HomeViewController = HomeViewController()
//        self.present(controller, animated: true, completion: nil)
//
//
//    }
    
    
        func result(gifname:String)  {
         DispatchQueue.main.async {
            let containerView = UIView()
            let progressView = UIView()
            var pinchImageView = UIImageView()
            let button = UIButton()
    
            containerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            
            
            let imageData = NSData(contentsOf: Bundle.main.url(forResource: gifname, withExtension: "gif")!)
            let animatedImage = UIImage.gif(data: imageData! as Data)
             
            
            pinchImageView = UIImageView(image: animatedImage)
            pinchImageView.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height:  self.view.frame.height)
            //        pinchImageView.center = CGPointMake(30.0, 30.0);
            progressView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            progressView.center = self.view.center
            progressView.addSubview(pinchImageView)
            containerView.addSubview(progressView)
            self.view.addSubview(containerView)
                
            button.frame = CGRect(x: self.view.frame.size.width-70, y: 30, width: 70, height: 70)
            button.setImage(UIImage(named:"closepopup"), for: .normal)
            button.addTarget(self, action: #selector(self.BtnTap), for: UIControl.Event.touchUpInside)
            containerView.addSubview(button)
            
    }
    
 }
    
    
        @objc func BtnTap(){
    
            if transStatus == "Transaction Successful" {
    
            let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
            let tab = storyBoard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
            tab.selectedIndex = 0
            self.navigationController?.pushViewController(tab, animated: true)
                
            } else if self.transStatus == "Transaction Failed" {
                
                let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
                let tab = storyBoard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
                self.navigationController?.pushViewController(tab, animated: true)
                
            } else {
    
                let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
                let tab = storyBoard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
                self.navigationController?.pushViewController(tab, animated: true)
    
    
            }
    
    
    
        }
    
}
