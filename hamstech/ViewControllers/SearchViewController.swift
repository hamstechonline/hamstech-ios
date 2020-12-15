//
//  SearchViewController.swift
//  hamstech
//
//  Created by Priyanka on 18/06/20.
//

import UIKit

protocol SearchSendingDelegate: class {
    
    func Searchdata(courceid : String, Catid: String, catname: String)
   
}



class SearchViewController: UIViewController {

    @IBOutlet weak var search_Table: UITableView!
    @IBOutlet weak var table_Height: NSLayoutConstraint!
    
    var SearchistingData = [SearchResponseModel]()
    var SearchistingData1 = [SearchResponseModel]()
    var from = String()
    
    weak var Searchdelegate: SearchSendingDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        table_Height.constant = CGFloat(SearchistingData1.count*120)
        Searchservicecalling()
        
       // let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissView))
       //  view.addGestureRecognizer(tapGesture)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func dismiss_Action(_ sender: Any) {
        
        self.dismiss(animated: false, completion: nil)
        
    }
    
    @objc func dismissView() {

     // self.dismiss(animated: false, completion: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.isHidden = true
        
    }

    func Searchservicecalling(){

        if Reachability.isConnectedToNetwork(){

            
        let Urlname = "\(ConstantsKeys.AppLinks.BaseUrl)\(ConstantsKeys.AppGetUrls.get_search)"

    let params  = ["metadata":["appname":"Hamstech","page":"search","apikey":"dsf99898398i3jofklese93"]]
              
            
             NetworkHelper.sharedInstance.postServiceCall(url: Urlname, PostDetails: params as [String : AnyObject]) { (response, error) in
           
                 
             let status:String =  String(response["status"] as! String)

                if status == "ok"{

                  
                    
                    self.SearchistingData.removeAll()
                    if let dataArrya = response["course_list"] as? [[String: Any]] {
                        
                      print("dataArrya:", dataArrya)
                        
                        
                    for list in dataArrya {
                    let object = SearchResponseModel(data: list as NSDictionary)
                    self.SearchistingData.append(object)
                        
                    }
                        
                    self.SearchistingData1 = self.SearchistingData
                        
                        
                    
                  }
                    
                }else {
          
               self.view.window?.makeToast(response["message"] as? String, duration: 2.0, position: CSToastPositionCenter)
              }
         
            }
        } else
             {
             self.customPresentAlert(withTitle: "", message: "Please Check Network Connection")
        }

    }

    
    @IBAction func Search_Action(_ sender: UITextField) {
        
        
        
//        if sender.text == "" {
//
//            search_Table.isHidden = true
//
//        }
    //    else {
        
        let serchstring = sender.text
        SearchistingData1 = SearchistingData.filter({(categoryName: SearchResponseModel) in
            return categoryName.coursename_categoryname.lowercased().range(of: (serchstring!.lowercased())) != nil
        })
            
//            if SearchistingData1.count == 0 {
//              search_Table.isHidden = true
//            } else {
//              search_Table.isHidden = false
         search_Table.reloadData()
//
//            }
//
//        }

        if SearchistingData1.count > 4 {
           
            table_Height.constant = 500
            
        } else {
        
        table_Height.constant = CGFloat(SearchistingData1.count*120)
    }
        
    //}

}


}


//Footer - UITabbar functionality for slide menu controller


extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        SearchistingData1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = search_Table.dequeueReusableCell(withIdentifier: "SeaecTableViewCell", for: indexPath) as! SeaecTableViewCell
        
        let iamge = SearchistingData1[indexPath.row].image_url ?? ""
        
        cell.search_Img.setKFImage(with: iamge)
        
        let courcename = SearchistingData1[indexPath.row].coursename_categoryname
        
        cell.search_Lbl.text = courcename!
        
        
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
       // UITableView.automaticDimension
       return 120
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if self.from == "Fashionstyling" {
            
            Searchdelegate?.Searchdata(courceid: SearchistingData1[indexPath.row].courseId, Catid: SearchistingData1[indexPath.row].categoryId, catname: SearchistingData1[indexPath.row].course_name)
            self.dismiss(animated: true, completion: nil)
            
        } else {
        
       let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "FashionStylingViewController") as? FashionStylingViewController
           
        vc?.catname = SearchistingData1[indexPath.row].course_name
        vc?.courceid = SearchistingData1[indexPath.row].courseId
        vc?.catid = SearchistingData1[indexPath.row].categoryId
       
       self.navigationController?.pushViewController(vc!, animated: true)
    }
    }
    
    
}
