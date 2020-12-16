//
//  OnbordingViewController.swift
//  hamstech
//
//  Created by Priyanka on 11/05/20.
//

import UIKit

class OnbordingViewController: UIViewController {
    
    @IBOutlet weak var onbordingCollection: UICollectionView!
    @IBOutlet weak var onboardpagecontroller: UIPageControl!
    @IBOutlet weak var skip_But: UIButton!
    
    var timer:Timer!
 
    
    var images = ["first","secound"]
    
    var OnbordingBanners = [OnBordingResponseModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ActivityServiceCalling(Pagename: "Onbording", Activity: "Viewed")
        
        skip_But.layer.cornerRadius = 15
        
        // logged in or not
        let Logedincheck: String = UserDefaults.standard.object(forKey: "logedin") as? String ?? ""

        if Logedincheck == "Userlogedin" {

            let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
            let tab = storyBoard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
            tab.selectedIndex = 0
            //[rev pushFrontViewController:tab animated:true];
            self.navigationController?.pushViewController(tab, animated: true)

        } else if Logedincheck == "Firsttime" {

            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RegisterOtpViewController") as? RegisterOtpViewController
            self.navigationController?.pushViewController(vc!, animated: true)

        } else {
          
            OnbordingServiceCalling()
            
            onbordingCollection.isHidden = false
            onboardpagecontroller.isHidden = false
            skip_But.isHidden = false
            
//            self.timer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(OnbordingViewController.autoScrollImageSlider), userInfo: nil, repeats: true)
//            RunLoop.main.add(self.timer, forMode: RunLoop.Mode.common)
            
        }

    }
   
    
   
    
    func OnbordingServiceCalling() {

        if Reachability.isConnectedToNetwork(){


            let Urlname = "\(ConstantsKeys.AppLinks.BaseUrl)\(ConstantsKeys.AppGetUrls.boardingpage)"

            let params  = ["metadata": ["appname":ConstantsKeys.apikey.appname, "apikey": ConstantsKeys.apikey.api_key,"page": "boardingpage","lang":ConstantsKeys.apikey.lan] ] as [String : Any]

        ActivityIndicatorWithLabel.shared.showProgressView(uiView: view)
        NetworkHelper.sharedInstance.postServiceCall(url: Urlname, PostDetails: params as [String : AnyObject]) { (response, error) in
       ActivityIndicatorWithLabel.shared.hideProgressView()
            
            
        let status:String =  String(response["status"] as! String)

        print(response)
          
            
        if status == "ok"{
            
            
            
        self.OnbordingBanners.removeAll()
        if let dataArrya = response["broadingpage"] as? [[String: Any]] {
        for list in dataArrya {
        let object = OnBordingResponseModel(data: list as NSDictionary)
        self.OnbordingBanners.append(object)
        }

        self.onbordingCollection.reloadData()

        }

        }else {


            
      //  self.view.window?.makeToast(response["message"] as? String, duration: 2.0, position: CSToastPositionCenter)
            
         }
        }
        }
        else
        {
        self.customPresentAlert(withTitle: "", message: "Please Check Network Connection")
        }
    }
    
    
    
    @objc func autoScrollImageSlider() {

        DispatchQueue.main.async {

        let visibleItems = self.onbordingCollection.indexPathsForVisibleItems

        if visibleItems.count > 0 {

        let currentItemIndex: IndexPath? = visibleItems[0]

        if currentItemIndex?.item == self.OnbordingBanners.count - 1 {
            
        UserDefaults.standard.set("Firsttime", forKey: "logedin")

        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RegisterOtpViewController") as? RegisterOtpViewController
        self.navigationController?.pushViewController(vc!, animated: true)
            
            
       // let nexItem = IndexPath(item: 0, section: 0)

       // self.onbordingCollection.scrollToItem(at: nexItem, at: .centeredHorizontally, animated: true)
            

        } else {

            
            
        let nexItem = IndexPath(item: (currentItemIndex?.item ?? 0) + 1, section: 0)

        self.onbordingCollection.scrollToItem(at: nexItem, at: .centeredHorizontally, animated: true)
            
            
        }
        }
        }

    }
    

    // Skip Button
    
    @IBAction func skip_Action(_ sender: Any) {
        
         ActivityServiceCalling(Pagename: "Onbording", Activity: "Skiped")
        UserDefaults.standard.set("Firsttime", forKey: "logedin")

        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RegisterOtpViewController") as? RegisterOtpViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        
        
        
    }
 
    

}

extension OnbordingViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return OnbordingBanners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
               
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! OnbordingCollectionViewCell
        
        let image = OnbordingBanners[indexPath.row].upload_images ?? ""
        
        cell.onbording_Img.setKFImage(with: image)

            return cell

            
       }

      func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
    
          return CGSize(width: (CGFloat) (self.onbordingCollection.frame.size.width) ,height: (CGFloat) (self.onbordingCollection.frame.size.height))
        
      }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        
        self.onboardpagecontroller.numberOfPages = OnbordingBanners.count
        self.onboardpagecontroller.currentPage = indexPath.row
     
    }
    
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }


    }


  

