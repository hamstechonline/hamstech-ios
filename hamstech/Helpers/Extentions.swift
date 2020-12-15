//
//  LifeAtHamstechViewController.swift
//  hamstech
//
//  Created by Priyanka on 15/05/20.
//

import Foundation
import UIKit
import Alamofire
import Kingfisher

@nonobjc extension UIViewController {
    func add(_ child: UIViewController, frame: CGRect? = nil) {
        addChild(child)
        
        if let frame = frame {
            child.view.frame = frame
        }
        
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        
        print("Remove Screen")
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    // Applying shadow on UIViews
    func applyShadowOnView(_ view:UIView) {

            view.layer.cornerRadius = 8
            view.layer.shadowColor = UIColor.lightGray.cgColor
            view.layer.shadowOpacity = 1
            view.layer.shadowOffset = CGSize.zero
            view.layer.shadowRadius = 5

    }
    
    func ActivityServiceCalling(Pagename: String, Activity : String) {

            if Reachability.isConnectedToNetwork(){

            //email,password,device_type,device_token

            let Urlname = "\(ConstantsKeys.AppLinks.BaseUrl)\(ConstantsKeys.AppGetUrls.logevent)"

    let params  = ["metadata": ["appname":ConstantsKeys.apikey.appname, "apikey": ConstantsKeys.apikey.api_key],"data":["mobile":"","fullname":"fUr34qeN7Lk:APA91bEGX_saUe9tjj6VrkkLMntTX1VTkZC-_7sMiVjjyiltYhZ3_0wgkprzpPTZ7ipy9hHjRaZNE7Pw06ziUl2xwiYq5CBoEDspUbiYHSKmofOhMcfQsjX3d81qtOyAL1lC8BSFftLS","email":"","category":"","course":"","lesson":"","activity":Activity,"pagename":Pagename,"lang":""]] as [String : Any]

                
           // ActivityIndicatorWithLabel.shared.showProgressView(uiView: view)
            NetworkHelper.sharedInstance.postServiceCall(url: Urlname, PostDetails: params as [String : AnyObject]) { (response, error) in
          // ActivityIndicatorWithLabel.shared.hideProgressView()
                
            let status:String =  String(response["status"] as! String)

                print("response", response)
                
            if status == "ok"{

                
           // self.view.window?.makeToast(response["message"] as? String, duration: 2.0, position: CSToastPositionCenter)
                
             }
            }
            }
            else
            {
            self.customPresentAlert(withTitle: "", message: "Please Check Network Connection")
            }
        }
    
  
}

extension UITableView {

    func reloadWithoutAnimation() {
        let lastScrollOffset = contentOffset
        beginUpdates()
        layer.removeAllAnimations()
        setContentOffset(lastScrollOffset, animated: false)
        reloadData()
        endUpdates()
    }
}
// ALL Extension Here

extension UIViewController {

        func getFormattedDate(string: String , formatter:String) -> String{
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "MMM dd,yyyy"

            let date: Date? = dateFormatterGet.date(from: "2018-02-01T19:10:04+00:00")
            print("Date",dateFormatterPrint.string(from: date!)) // Feb 01,2018
            return dateFormatterPrint.string(from: date!);
        }
  

    func showToast(message : String) {
        
        let message = message
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        self.present(alert, animated: true)
        
        let duration: Double = 2
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
            alert.dismiss(animated: true)
        }
    }
    func customPresentAlert(withTitle title: String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title:  "OK", style: .default) { action in
            print("You've pressed OK Button")
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    func reloadViewFromNib() {
        let parent = view.superview
        view.removeFromSuperview()
        view = nil
        parent?.addSubview(view)
    }
    
    
    func socialmedia(mediaurl : String){
        
        let appURL = URL(string: mediaurl)!

        if #available(iOS 10.0, *) {
        UIApplication.shared.open(appURL as URL, options: [:], completionHandler: nil)
        }
        else {
        UIApplication.shared.openURL(appURL as URL)
        }
        
    }
    
  // mobile number validation
    
  func isValidPhone(phone: String) -> Bool{
      
         let phoneRegEx = "[0-9]{10}$"
         let phoneTest = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
         let result = phoneTest.evaluate(with: phone)
         return result
     }
    
}
// assign Service Image string file to uiimageview
extension UIImage {
    convenience init?(url: URL?) {
        guard let url = url else { return nil }
        
        do {
            let data = try Data(contentsOf: url)
            self.init(data: data)
        } catch {
            print("Cannot load image from url: \(url) with error: \(error)")
            return nil
        }
  }
}
// useage profilePicImageView.image = UIImage.init(url: URL.init(string: profilePath!))

extension String {
    
    func isValidEmailCondition() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }

    
    
}


func isValidemail(emailAddress: String) -> Bool {
    let REGEX: String
    REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
    return NSPredicate(format: "SELF MATCHES %@", REGEX).evaluate(with: emailAddress)
}

func isValidPinCode(Indiapincode: String?) -> Bool {
    let pinRegex = "^[0-9]{6}$"
    let pinTest = NSPredicate(format: "SELF MATCHES %@", pinRegex)

    let pinValidates = pinTest.evaluate(with: Indiapincode)
    return pinValidates
}


/* Removing HTML Tags */
extension String {
    public var withoutHtml: String {
        
        guard let data = self.data(using: .utf8) else {
            return self
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return self
        }
        
        return attributedString.string
    }
}
// Showing two Digits in double
extension Double {
    var twoDigitsString:String {
        return String(format: "%.2f", self)
    }
}

extension String{
    func strikeThrough()->NSAttributedString{
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}


extension UIImageView {
    func setKFImage(with urlString: String){
        guard let url = URL.init(string: urlString) else {
            return
        }
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        let kf = self.kf
        kf.indicatorType = .activity
        self.kf.setImage(with: resource)
    }
    
    func setCircleForImage(_ imageView : UIImageView){
        imageView.layer.cornerRadius = imageView.frame.size.width/2
        imageView.clipsToBounds = true
    }
    
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

extension UIView {
    
    func dropShadow1(scale: Bool = true) {
        
        layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.8
        layer.shadowOffset = .zero
        layer.shadowRadius = 4
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
        
    }

    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        
        }
     
}

extension UIView {
    

}

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}


protocol CaseCountable { }

extension CaseCountable where Self : RawRepresentable, Self.RawValue == Int {
    
    static var count: Int {
        var count = 0
        while Self(rawValue: count) != nil { count+=1 }
        return count
    }
    
    static var allValues: [Self] {
        return (0..<count).compactMap({ Self(rawValue: $0) })
    }
    
}

extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}




