//
//  CCWebViewController.swift
//  CCIntegrationKit_Swift
//


import UIKit
import Foundation

/**
 * class: CCWebViewController
 * CCWebViewController is responsible for to take all the values from the merchant and process futher for the payment
 * We will generate the RSA Key for this transaction first by using access code of the merchant and the unique order id for this transaction
 * After generating Successful RSA Key we will use that key for encrypting amount and currency and the encrypted details will use for intiate the transaction
 * Once the transaction is done  we will pass the transaction result to the next page (ie CCResultViewController here)
 */

class CCWebViewController: UIViewController,UIWebViewDelegate {
    
    var accessCode = String()
    var merchantId = String()
    var orderId = String()
    var amount = String()
    var currency = String()
    var selectedCourseId = String()
    var redirectUrl = String()
    var cancelUrl = String()
    var rsaKeyUrl = String()
    var billing_FirstName = String()
    var billing_LastName = String()
    var billing_Email = String()
    var billing_Phone = String()
    var billing_Address = String()
    var billing_Locality = String()
    var billing_City = String()
    var billing_State = String()
    var billing_Pincode = String()
    var rsaKeyDataStr = String()
    var rsaKey = String()
    static var statusCode = 0//zero means success or else error in encrption with rsa
    var encVal = String()
    var isHere = false
    
    private var notification: NSObjectProtocol?
    
    lazy var viewWeb: UIWebView = {
        let webView = UIWebView()
        webView.backgroundColor = .white
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.delegate = self
        webView.scalesPageToFit = true
        webView.contentMode = UIView.ContentMode.scaleAspectFill
        webView.tag = 1011
        return webView
    }()
    
    var request: NSMutableURLRequest?
    
    var ccAvenueReferenceId = String()
     var transStatus = String()
    var NavigationBar = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = .white
        viewWeb.delegate = self
        setupWebView()
        notification = NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) {
            [unowned self] notification in
            self.checkResponseUrl()
            
        }
    }
    
    
    
    deinit {
        if let notification = notification {
            NotificationCenter.default.removeObserver(notification)
        }
    }
    
    fileprivate func checkResponseUrl(){

        let string = (viewWeb.request?.url?.absoluteString)!
        print("String :: \(string)")
        
        if(string.contains(redirectUrl)) //("http://122.182.6.216/merchant/ccavResponseHandler.jsp"))//
        {
            
            print(viewWeb.isLoading)
            
            let htmlTemp = viewWeb.stringByEvaluatingJavaScript(from: "document.documentElement.outerHTML")
            let html = htmlTemp
            print("html :: ",html)
            
            ccAvenueReferenceId = html!.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
            print("ccAvenueReferenceId = \(ccAvenueReferenceId)")
            
            transStatus = "Not Known"
            
            if (html! as NSString).contains("Success") {
                print("Success")
              
                
                 self.sendingTransactionDetails()
                

                
            }
            else if (html! as NSString).contains("Failure") {
                print("Failure")
                transStatus = "Transaction Failed"
                
                
               // If status failure redirecting to CCResultViewController
               
               let controller: CCResultViewController = CCResultViewController()
               controller.transStatus = transStatus
                self.navigationController?.pushViewController(controller, animated: true)
              // self.present(controller, animated: true, completion: nil)
                
            }
            else if (html! as NSString).contains("Cancel") {
                print("Cancel")
                transStatus = "Transaction Cancelled"
                
                
              // If status cancel redirecting to CCResultViewController
              let controller: CCResultViewController = CCResultViewController()
              controller.transStatus = transStatus
            self.navigationController?.pushViewController(controller, animated: true)
             // self.present(controller, animated: true, completion: nil)
                
                }
            else {
                print("html does not contain any related data")
                displayAlert(msg: "Something went wrong")
                }
            }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /**
         * In viewWillAppear we will call gettingRsaKey method to generate RSA Key for the transaction and use the same to encrypt data
         */
        
        self.navigationController?.navigationBar.isHidden = true
        
        if !isHere {
            isHere = true
            self.gettingRsaKey(){
                (success, object) -> () in
                DispatchQueue.main.sync {
                    if success {
                        self.encyptCardDetails(data: object as! Data)
                    }
                    else{
                        self.displayAlert(msg: object as! String)
                    }
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        LoadingOverlay.shared.showOverlay(view: self.view)
    }
    
    //MARK:
    //MARK: setupWebView
    
    private func setupWebView(){

        // NavigationBar
        NavigationBar = UIView()
        NavigationBar.frame = CGRect(x: 0, y: 0, width:self.view.frame.size.width, height: 70)
        NavigationBar.backgroundColor = UIColor.white
        self.view.addSubview(NavigationBar)
        
        //BackButton
        let image = UIImage(named: "Back") as UIImage?
        let button   = UIButton(type: UIButton.ButtonType.custom) as UIButton
        button.frame = CGRect(x: 15, y: 25, width: 40, height: 40)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: Selector("backButtonAction"), for:.touchUpInside)
        NavigationBar.addSubview(button)
        
     
        //setup webview
                view.addSubview(viewWeb)
                if #available(iOS 11.0, *) {
                    viewWeb.topAnchor.constraint(equalTo:NavigationBar.bottomAnchor).isActive = true
                    viewWeb.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
                } else {
                    // Fallback on earlier versions
                    viewWeb.topAnchor.constraint(equalTo: NavigationBar.bottomAnchor).isActive = true
                    viewWeb.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
                }
                    
        
                viewWeb.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
                viewWeb.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
                _ = [viewWeb .setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: NSLayoutConstraint.Axis.vertical)]
    
    }
    
    @objc func backButtonAction() {
        
        self.navigationController?.popViewController(animated: true)
       // self.dismiss(animated: true, completion: nil)
    }
    
    //MARK:
    //MARK: Get RsaKey & encrypt card details
    
    /**
     * In this method we will generate RSA Key from the URL for this we will pass order id and the access code as the request parameter
     * after the successful key generation we'll pass the data to the request handler using complition block
     */
    
    private func gettingRsaKey(completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()){
        DispatchQueue.main.async {
         // self.rsaKeyDataStr = "access_code=\(self.accessCode)&order_id=\(self.orderId)"
            
            self.rsaKeyDataStr = "ORDER_ID=\(self.orderId)"
            
            let requestData = self.rsaKeyDataStr.data(using: String.Encoding.utf8)
            
            guard let urlFromString = URL(string: self.rsaKeyUrl) else{
                return
            }
            
            var urlRequest = URLRequest(url: urlFromString)
            urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type")
            urlRequest.httpMethod = "POST"
            urlRequest.httpBody = requestData
            
            let session = URLSession(configuration: URLSessionConfiguration.default)
            print("session",session)
            
            session.dataTask(with: urlRequest as URLRequest) {
                (data, response, error) -> Void in
                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode{
                    guard let responseData = data else{
                        print("No value for data")
                        completion(false, "Not proper data for RSA Key" as AnyObject?)
                        return
                    }
                    print("data :: ",responseData)
                    completion(true, responseData as AnyObject?)
                }
                else{
                    completion(false, "Unable to generate RSA Key please check" as AnyObject?)                }
                }.resume()
        }
    }
    
    /**
     * encyptCardDetails method we will use the rsa key to encrypt amount and currency and onece the encryption is done we will pass this encrypted data to the initTrans to initiate payment
     */
    
    private func encyptCardDetails(data: Data){
        guard let rsaKeytemp = String(bytes: data, encoding: String.Encoding.ascii) else{
            print("No value for rsaKeyTemp")
            return
        }
        rsaKey = rsaKeytemp
        rsaKey = self.rsaKey.trimmingCharacters(in: CharacterSet.newlines)
        rsaKey =  "-----BEGIN PUBLIC KEY-----\n\(self.rsaKey)\n-----END PUBLIC KEY-----\n"
        print("rsaKey :: ",rsaKey)
        
        let myRequestString = "amount=\(amount)&currency=\(currency)"
        
        do{
            let encodedData = try RSAUtils.encryptWithRSAPublicKey(str: myRequestString, pubkeyBase64: rsaKey)
            var encodedStr = encodedData?.base64EncodedString(options: [])
            let validCharSet = CharacterSet(charactersIn: "!*'();:@&=+$,/?%#[]").inverted
            encodedStr = encodedStr?.addingPercentEncoding(withAllowedCharacters: validCharSet)
            CCWebViewController.statusCode = 0
            
            //Preparing for webview call
            if CCWebViewController.statusCode == 0{
                CCWebViewController.statusCode = 1
                let urlAsString = "https://secure.ccavenue.com/transaction/initTrans"
                
                
              //  access code,merchsnt id, order id, currency, amount, billing name, billing address,biilling city, billing telephone, billing email, redirect url, cancel url,rsakeurl
                
                
                
               // let encryptedStr = "merchant_id=\(merchantId)&order_id=\(orderId)&redirect_url=\(redirectUrl)&cancel_url=\(cancelUrl)&enc_val=\(encodedStr!)&access_code=\(accessCode)"
                
                
                 let encryptedStr = "merchant_id=\(merchantId)&order_id=\(orderId)&redirect_url=\(redirectUrl)&cancel_url=\(cancelUrl)&enc_val=\(encodedStr!)&access_code=\(accessCode)&billing_name=\(billing_FirstName)&billing_tel=\(billing_Phone)&billing_email=\(billing_Email)&billing_address=\(billing_Address)&billing_country=\(billing_Locality)&billing_city=\(billing_City)&billing_state=\(billing_State)&billing_zip=\(billing_Pincode)"
                
                
             //   let encryptedStr = "merchant_id=\(merchantId)&order_id=\(orderId)&redirect_url=\(redirectUrl)&cancel_url=\(cancelUrl)&enc_val=\(encodedStr!)&access_code=\(accessCode)&language=EN&billing_name=Charli&billing_address=Room no 1101, near Railway station Ambad&billing_city=Indore&billing_state=MH&billing_zip=425001&billing_country=India&billing_tel=9595226054&billing_email=abc@test.com&delivery_name=Chaplin&delivery_address=room no.701 near bus stand&delivery_city=Hyderabad&delivery_state=Andhra&delivery_zip=425001&delivery_country=India&delivery_tel=9595226054&merchant_param1=additional Info&merchant_param2=additional Info&merchant_param3=additional Info&merchant_param4=additional Info&payment_option=OPTDBCRD&card_type=DBCRD&card_name=Visa Debit Card&data_accept=Y&issuing_bank=State Bank Of India&mobile_no=9595226054&emi_plan_id=null&emi_tenure_id=null&saveCard=Y"
            
                
                let myRequestData = encryptedStr.data(using: String.Encoding.utf8)
                
                request  = NSMutableURLRequest(url: URL(string: urlAsString)! as URL, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 30)
                request?.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type")
                request?.setValue(urlAsString, forHTTPHeaderField: "Referer")
                request?.httpMethod = "POST"
                request?.httpBody = myRequestData
                self.viewWeb.loadRequest(self.request! as URLRequest)
            }
            else{
                
                print("Unable to create requestURL")
                displayAlert(msg: "Unable to create requestURL")
                
            }
        }
        catch let err {
            print(err)
        }
    }
    
    func displayAlert(msg: String){
        let alert: UIAlertController = UIAlertController(title: "ERROR", message: msg, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            LoadingOverlay.shared.hideOverlayView()
            
            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK:
    //MARK: WebviewDelegate Methods
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("Failed to load  webview")
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        LoadingOverlay.shared.hideOverlayView()
        
        //covert the response url to the string and check for that the response url contains the redirect/cancel url if true then chceck for the transaction status and pass the response to the result controller(ie. CCResultViewController)
        
        let string = (webView.request?.url?.absoluteString)!
        print("String :: \(string)")
        
        if(string.contains(redirectUrl)) //("http://122.182.6.216/merchant/ccavResponseHandler.jsp"))//
        {
            print(viewWeb.isLoading)
            
            let htmlTemp = webView.stringByEvaluatingJavaScript(from: "document.documentElement.outerHTML")
            let html = htmlTemp
            print("html :: ",html)
            
            ccAvenueReferenceId = html!.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
            print("ccAvenueReferenceId = \(ccAvenueReferenceId)")
            
            transStatus = "Not Known"
            
            if (html! as NSString).contains("Success") {
                print("Success")
                self.sendingTransactionDetails()
                
                
            }
            else if (html! as NSString).contains("Failure") {
                print("Failure")
                transStatus = "Transaction Failed"
               
                
                // If status failure redirecting to CCResultViewController
                
                let controller: CCResultViewController = CCResultViewController()
                controller.transStatus = transStatus
                 self.navigationController?.pushViewController(controller, animated: true)
              
                
            }
            else if (html! as NSString).contains("Cancel") {
                print("Cancel")
                
                transStatus = "Transaction Cancelled"
                
               
                
               // self.result(gifname:"final error full size1")
                
                
                
        
                 // If status cancel redirecting to CCResultViewController
                let controller: CCResultViewController = CCResultViewController()
                controller.transStatus = transStatus
                 self.navigationController?.pushViewController(controller, animated: true)
               // self.present(controller, animated: true, completion: nil)
                }
            else {
                print("html does not contain any related data")
                displayAlert(msg: "Something went wrong")
                }
            }
            
//             guard let htmlTemp:NSString = webView.stringByEvaluatingJavaScript(from: "document.documentElement.outerHTML") as NSString? else{
//                           print("failed to evaluate javaScript")
//                           return
//                       }
//
//                       let html = htmlTemp
//                       print("html :: ",html)

            
//            guard let htmlTemp:NSString = webView.stringByEvaluatingJavaScript(from: "document.documentElement.outerHTML") as NSString? else{
//                print("failed to evaluate javaScript")
//                return
//            }

//            let html = htmlTemp
//            print("html :: ",html)
//
            
            //  getting number from string
//            let result = html.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
//            print(result)
            
            
            // fetching data using body tag
//            let data = html.data(using: .utf8)!
//                       do {
//                           if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? Dictionary<String,Any>
//                           {
//                               print(jsonArray) // use the json here
//                           } else {
//                               print("bad json")
//                           }
//                       } catch let error as NSError {
//                           print(error)
//                       }
//

            
//            var transStatus = "Not Known"
//
//            if ((html ).range(of: "tracking_id").location != NSNotFound) && ((html ).range(of: "bin_country").location != NSNotFound) {
//                if ((html ).range(of: "Aborted").location != NSNotFound) || ((html ).range(of: "Cancel").location != NSNotFound) {
//                    transStatus = "Transaction Cancelled"
//                    let controller: CCResultViewController = CCResultViewController()
//                    controller.transStatus = transStatus
//                    self.present(controller, animated: true, completion: nil)
//                }
//                else if ((html ).range(of: "Success").location != NSNotFound) {
//                    transStatus = "Transaction Successful"
//                    let controller: CCResultViewController = CCResultViewController()
//                    controller.transStatus = transStatus
//                    self.present(controller, animated: true, completion: nil)
//                }
//                else if ((html ).range(of: "Fail").location != NSNotFound) {
//                    transStatus = "Transaction Failed"
//                    let controller: CCResultViewController = CCResultViewController()
//                    controller.transStatus = transStatus
//                    self.present(controller, animated: true, completion: nil)
//                }
//            }
//            else{
//                print("html does not contain any related data")
//                displayAlert(msg: "html does not contain any related data for this transaction.")
//            }
//        }
    
}
    
    func sendingTransactionDetails() {
                  
                   if Reachability.isConnectedToNetwork(){
                    let Urlname =  "\(ConstantsKeys.AppLinks.BaseUrl)\(ConstantsKeys.AppGetUrls.transcationDetails)"
                   
                   
                  let params  = ["apikey":ConstantsKeys.apikey.api_key,"appname":"Hamstech","phone":billing_Phone,"page":"PaymentPage","courseid":selectedCourseId,"course_language":"English","orderid":ccAvenueReferenceId,"order_amount":amount,"billing_address":billing_Address,"billing_city":billing_City,"billing_country":billing_State,"billing_pincode":billing_Pincode] as [String : Any]
                   
                   print("params = \(params)")
                           
                                   
                      
                   ActivityIndicatorWithLabel.shared.showProgressView(uiView: view)
                  NetworkHelper.sharedInstance.postServiceCall(url: Urlname, PostDetails: params as [String : AnyObject]) { (response, error)  in

                  ActivityIndicatorWithLabel.shared.hideProgressView()

                    let status = response["status"] as! NSDictionary
                    let message = status["message"] as! NSDictionary
                    
                     let responsecode:String =   String(message["status_message"] as! String)
                   
                    
                    print(responsecode)
                    
                    if responsecode == "success" {
                     
                    self.transStatus = "Transaction Successful"
                                           
                                           
                                           
                    // If status success redirecting to CCResultViewController
                    let controller: CCResultViewController = CCResultViewController()
                    controller.transStatus = self.transStatus
                    // self.present(controller, animated: true, completion: nil)
                    self.navigationController?.pushViewController(controller, animated: true)
                   
                        
                        
                    } else {
                      
                       // Do nothing
                    }

                   
                  }

                  }
           
                  else
                  {
                      self.customPresentAlert(withTitle: "", message: "Please Check Network Connection")
                  }
              }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    
}

