//
//  TabBarViewController.swift
//  hamstech
//
//  Created by Priyanka on 29/04/20.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    let button = UIButton.init(type: .custom)
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            
          //  button.setTitle("", for: .normal)
            button.setImage(UIImage(named: "discover"), for: .normal)
           // button.setTitleColor(.black, for: .normal)
           // button.setTitleColor(.yellow, for: .highlighted)

           // button.backgroundColor = .orange
           // button.layer.cornerRadius = 32
           // button.layer.borderWidth = 4
            //button.layer.borderColor = UIColor.yellow.cgColor
            
            self.view.insertSubview(button, aboveSubview: self.tabBar)
            button.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)

            view.layoutIfNeeded()
            
            self.delegate = self
            
           // setupMiddleButton()
        }
        
    
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    
        if item == (self.tabBar.items!)[1]{
         print("course item")
     
           UserDefaults.standard.set("tab", forKey: "tabbar")
            
         let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
         let tab = storyBoard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
         tab.selectedIndex = 0
          
         self.navigationController?.pushViewController(tab, animated: false)
            
         } else if item == (self.tabBar.items!)[0]{
            
             print("course item")
         
             let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
             let tab = storyBoard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
             tab.selectedIndex = 0
              
             self.navigationController?.pushViewController(tab, animated: false)
             }
         
    }
    
    
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            
            let height = self.tabBar.frame.size.height+6
            
            // safe place to set the frame of button manually
            button.frame = CGRect.init(x: self.tabBar.center.x - CGFloat(height)/2, y: CGFloat(self.tabBar.frame.origin.y)-CGFloat(height )/2, width: height , height: height )
        }
        
        @objc private func menuButtonAction(sender: UIButton) {
            selectedIndex = 2
            
//            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MentorsViewController") as? MentorsViewController
//                       self.navigationController?.pushViewController(vc!, animated: true)
        }
        
    //    @objc func pressButton(button: UIButton) {
    //        print("Button with tag: \(button.tag) clicked!")
    //       // let prodListController = BlackViewController()
    //       // self.navigationController?.pushViewController(prodListController, animated: true)
    //    }

        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
    override func viewWillAppear(_ animated: Bool) {
           self.navigationController?.navigationBar.isHidden = true
       }
    
//         func setupMiddleButton() {
//            let menuButton = UIButton(frame: CGRect(x: self.tabBar.center.x - 32, y: self.view.bounds.height - 104, width: 64, height: 64))
//
//                var menuButtonFrame = menuButton.frame
//                menuButtonFrame.origin.y = view.bounds.height - menuButtonFrame.height
//                menuButtonFrame.origin.x = view.bounds.width/2 - menuButtonFrame.size.width/2
//                menuButton.frame = menuButtonFrame
//
//                menuButton.backgroundColor = UIColor.red
//                menuButton.layer.cornerRadius = menuButtonFrame.height/2
//                view.addSubview(menuButton)
//
//                menuButton.setImage(UIImage(named: "example"), for: .normal)
//                menuButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)
//
//                view.layoutIfNeeded()
//            }


            // MARK: - Actions

    //        @objc private func menuButtonAction(sender: UIButton) {
    //            selectedIndex = 2
    //        }
        
    }


