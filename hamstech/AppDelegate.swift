//
//  AppDelegate.swift
//  hamstech
//
//  Created by Priyanka on 28/04/20.
//

import UIKit
import CoreData
import GoogleMaps
import GooglePlaces
import Firebase
import Messages
import IQKeyboardManagerSwift
import FBSDKCoreKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate {

    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"
    
    lazy var locationManager: CLLocationManager = {
        
        var _locationManager = CLLocationManager()
        //_locationManager.delegate = self as! CLLocationManagerDelegate
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest
        _locationManager.activityType = .automotiveNavigation
        _locationManager.distanceFilter = 10.0
        return _locationManager
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
         GMSPlacesClient.provideAPIKey("AIzaSyC5mgxJlyiFbnxpJHU1OCMqnV-kwU4XJy4")
          GMSServices.provideAPIKey("AIzaSyC5mgxJlyiFbnxpJHU1OCMqnV-kwU4XJy4")
        
        // Override point for customization after application launch.
        
//        ApplicationDelegate.shared.application(
//                       application,
//                       didFinishLaunchingWithOptions: launchOptions
//                   )
        
        // firebase
        FirebaseApp.configure()
        
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
          UNUserNotificationCenter.current().delegate = self

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
        } else {
          let settings: UIUserNotificationSettings =
          UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()
        
        //messaging
        Messaging.messaging().delegate = self
        // end
       
     if Reachability.isConnectedToNetwork()
      {
          self.isAuthorizedtoGetUserLocation()
      }else
      {
          print("no internet")
          //showToastForAlert (message: languageChangeString(a_str: "Please ensure you have proper internet connection")!)
      }
        
    // Keyboard
       IQKeyboardManager.shared.enable = true
        
        // Facebook events
               ApplicationDelegate.shared.application(
                   application,
                   didFinishLaunchingWithOptions: launchOptions
               )
        
        return true
    }
    
    
    func isAuthorizedtoGetUserLocation() {
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse  {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    
    // Dynamic Linking
    
     func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
             let dynamicLink = DynamicLinks.dynamicLinks().dynamicLink(fromCustomSchemeURL: url)
             if dynamicLink != nil {
                  //print("Dynamiclink : \(String(describing: dynamicLink?.url)”)
                print("Dynamiclink: \(dynamicLink?.url)")
                // Dynamiclink: Optional(https://www.hamstech.com/)
                
                
                
//                       print("url \(url)")
//                       print("url host :\(url.host!)")
//                       print("url path :\(url.path)")
//
//                let parameter = url.path
//                print("parameter = \(parameter)")
//
//                 if parameter == "/testing"
//                 {
//                    print("AboutUsViewController")
//
//                 let destinationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AboutUsViewController") as? AboutUsViewController
//                self.window?.rootViewController?.navigationController?.pushViewController(destinationVC!, animated: true)
//                    }
                                       
               // }
                
                  return true
             }
             return false
        }
        
        
        func application(_ application: UIApplication,
                         continue userActivity: NSUserActivity,
                         restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
            
            
            guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
                let url = userActivity.webpageURL,
                let host = url.host else {
                    return false
            }
            let parameter = url.path
            print("parameter = \(parameter)")
            
            let isDynamicLinkHandled =
                DynamicLinks.dynamicLinks().handleUniversalLink(url) { dynamicLink, error in

                    guard error == nil,
                        let dynamicLink = dynamicLink,
                        let urlString = dynamicLink.url?.absoluteString else {
                            return
                    }

                    guard let path = dynamicLink.url?.path else { return }
                    
                    
                    var id = 0
                    if let query = dynamicLink.url?.query {
                    let dataArray = query.components(separatedBy:"/")
                    id = Int(dataArray[1]) ?? 0
                        
                        print("Dyanmic link query: \(query)")
                        print("Dyanmic link dataArray: \(dataArray)")
                    }
                    
                    print("urlString = \(urlString)")
                    print("Dynamic link host: \(host)")
                    print("Dyanmic link path: \(path)")
    //                print("Dyanmic link dataArray: \(dataArray)")
                    print("Dynamic link match type: \(dynamicLink.matchType.rawValue)")
                    
                    // logedin or not
                    let Logedincheckfordynamiclinking: String = UserDefaults.standard.object(forKey: "logedin") as? String ?? ""

                    if Logedincheckfordynamiclinking == "Userlogedin" {

                      
                  if parameter == "/testing"
                    {
                        print("Redirect to specific screen")
                        
                       
//                        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                                    if let initialViewController : UIViewController = (mainStoryboardIpad.instantiateViewController(withIdentifier: "AboutUsViewController") as? AboutUsViewController) {
//                                           self.window = UIWindow(frame: UIScreen.main.bounds)
//                                           self.window?.rootViewController = initialViewController
//                                           self.window?.makeKeyAndVisible()
//
//                        }
                        
                        
                       
                    let storyboard = UIStoryboard(name:"Main", bundle: nil)
                    let myAppoint = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController
                        myAppoint?.selectedIndex = 4
                    var viewcontroller = UIApplication.shared.keyWindow?.rootViewController
                    let navigation = UINavigationController.init(rootViewController: myAppoint!)
                                          navigation.modalPresentationStyle = .overCurrentContext
                                          while ((viewcontroller?.presentedViewController) != nil)
                                          {
                                              viewcontroller = viewcontroller?.presentedViewController
                                          }
                                          viewcontroller?.present(navigation, animated: true, completion: nil)

                        
                    }
                        
                    }
                    else{
                        print("Redirect to register screen")
                        
                           let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            if let initialViewController : UIViewController = (mainStoryboardIpad.instantiateViewController(withIdentifier: "OnbordingViewController") as? OnbordingViewController) {
                                                                   self.window = UIWindow(frame: UIScreen.main.bounds)
                                                                   self.window?.rootViewController = initialViewController
                                                                   self.window?.makeKeyAndVisible()
                        
                                                }
                                                
                    }
                }
            return isDynamicLinkHandled
    }
    
    
//    func application(_ application: UIApplication,
//                     continue userActivity: NSUserActivity,
//                     restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
//
//      if let incomingURL = userActivity.webpageURL {
//        let linkHandled = DynamicLinks.dynamicLinks().handleUniversalLink(incomingURL, completion: { (dynamiclink, error) in
//          if let dynamiclink = dynamiclink, let _ =  dynamiclink.url {
//            self.handleIncomingDynamicLink(dynamiclink: dynamiclink)
//
//
//          }
//        })
//
//        return linkHandled
//      }
//
//      return false
//    }
//    func handleIncomingDynamicLink(dynamiclink: FirebaseDynamicLinks) {
//
//         guard let path = DynamicLink.url?.path else { return }
//                   for nextpiece in path {
//
//                   }
//
//
//    }
    
// Firebase start
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
     
        UserDefaults.standard.set(fcmToken, forKey: "fcmToken")
    }
     
     
    // firebase message delegate
     private func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
         print("token: \(fcmToken)")

         let dataDict:[String: String] = ["token": fcmToken]
         print("dataDict: \(dataDict)")
           NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
           // TODO: If necessary send token to application server.
           // Note: This callback is fired at each app startup and whenever a new token is generated.


         }
     
     // [START receive_message]
     func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
       // If you are receiving a notification message while your app is in the background,
       // this callback will not be fired till the user taps on the notification launching the application.
       // TODO: Handle data of notification

       // With swizzling disabled you must let Messaging know about the message, for Analytics
       // Messaging.messaging().appDidReceiveMessage(userInfo)

       // Print message ID.
       if let messageID = userInfo[gcmMessageIDKey] {
         print("Message ID: \(messageID)")
       }

       // Print full message.
       print(userInfo)
        
        print("Push notification received: \(userInfo)")

                
        
     }

     func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                      fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
       // If you are receiving a notification message while your app is in the background,
       // this callback will not be fired till the user taps on the notification launching the application.
       // TODO: Handle data of notification

       // With swizzling disabled you must let Messaging know about the message, for Analytics
       // Messaging.messaging().appDidReceiveMessage(userInfo)
         
         

       // Print message ID.
       if let messageID = userInfo[gcmMessageIDKey] {
         print("Message ID: \(messageID)")
       }

       // Print full message.
       print(userInfo)

       completionHandler(UIBackgroundFetchResult.newData)
         
     }
     // [END receive_message]
     func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
         print("Unable to register for remote notifications: \(error.localizedDescription)")
     }
     
     // This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
     // If swizzling is disabled then this function must be implemented so that the APNs token can be paired to
     // the FCM registration token.
     func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
         //print("APNs token retrieved: \(deviceToken)")
          Messaging.messaging().apnsToken = deviceToken

         let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
         print("APNs token retrieved:\(token)")

         // With swizzling disabled you must set the APNs token here.
         // Messaging.messaging().apnsToken = deviceToken
     }
     // Firebase End
    
    
    // MARK: - FaceBook Events & Dynamic linking when your app is opened for the first time
    func application(
                _ app: UIApplication,
                open url: URL,
                options: [UIApplication.OpenURLOptionsKey : Any] = [:]
            ) -> Bool {
             if (url.scheme == "fb849192265584660") {
                ApplicationDelegate.shared.application(
                    app,
                    open: url,
                    sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                    annotation: options[UIApplication.OpenURLOptionsKey.annotation]
                 // facebook events
     )
    } else {
         // dynamic linking
          return application(app, open: url, sourceApplication: nil, annotation: [:])
          
     }
      return true
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
        if UserDefaults.standard.bool(forKey: "checked") == true {
            
         UserDefaults.standard.set(false, forKey: "checked")
           
            
       let storyboard = UIStoryboard(name:"Main", bundle: nil)
        let myAppoint = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController
             myAppoint?.selectedIndex = 0
        var viewcontroller = UIApplication.shared.keyWindow?.rootViewController
        let navigation = UINavigationController.init(rootViewController: myAppoint!)
        navigation.modalPresentationStyle = .overCurrentContext
        while ((viewcontroller?.presentedViewController) != nil)
        {
            viewcontroller = viewcontroller?.presentedViewController
        }
        viewcontroller?.present(navigation, animated: true, completion: nil)
        UIApplication.shared.applicationIconBadgeNumber = 0
            
//        let storyBoard = UIStoryboard(name:"Main", bundle:nil)
//        let controller = storyBoard.instantiateViewController(withIdentifier: "TabBarViewController")
//        self.window?.rootViewController = controller;
 
            
        }
        
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "hamstech")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

// firebase start
// firebase UNUserNotificationCenterDelegate code
@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {

    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo

        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }

        // Print full message.
        print("userInfo = \(userInfo)")
        
               
        // Change this to your preferred presentation option

        completionHandler([.alert, .badge, .sound])
    }
    
    
    //Notification code when pressed from background/foreground/inactive
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
          let info = response.notification.request.content.userInfo
        
        if let aps = info["aps"] as? Dictionary<String,Any> {
                   
                   print("aps = \(aps)")
                   let alert = aps["alert"] as? Dictionary<String,Any>
            
                   print("alert = \(alert)")
            
                   let bodyString = alert!["body"] as! String
                   print("bodyString = \(bodyString)")
                   let titleString = alert!["title"] as! String
                   print("titleString = \(titleString)")
                   
            
                  let fcm_options = info["fcm_options"] as? Dictionary<String,Any>
                  print("fcm_options = \(fcm_options)")
            
                  let image = fcm_options!["image"] as! String
                  print("image = \(image)")
            
                   if let statusMessage = info["status"] {
                   print("NotificationstatusMessage = \(statusMessage)")
                    
                
                    if statusMessage as! String == "home_page" {
                        
                      
                   let storyboard = UIStoryboard(name:"Main", bundle: nil)
                   let myAppoint = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController
                        myAppoint?.selectedIndex = 0
                   var viewcontroller = UIApplication.shared.keyWindow?.rootViewController
                   let navigation = UINavigationController.init(rootViewController: myAppoint!)
                   navigation.modalPresentationStyle = .overCurrentContext
                   while ((viewcontroller?.presentedViewController) != nil)
                   {
                       viewcontroller = viewcontroller?.presentedViewController
                   }
                   viewcontroller?.present(navigation, animated: true, completion: nil)
                   UIApplication.shared.applicationIconBadgeNumber = 0
                        
                        
                        
                    } else if  statusMessage as! String == "contactus_page" {
                        
                let storyboard = UIStoryboard(name:"Main", bundle: nil)
                let myAppoint = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController
                        myAppoint?.selectedIndex = 4
                var viewcontroller = UIApplication.shared.keyWindow?.rootViewController
                let navigation = UINavigationController.init(rootViewController: myAppoint!)
                navigation.modalPresentationStyle = .overCurrentContext
                while ((viewcontroller?.presentedViewController) != nil)
                {
                viewcontroller = viewcontroller?.presentedViewController
                }
                viewcontroller?.present(navigation, animated: true, completion: nil)
                UIApplication.shared.applicationIconBadgeNumber = 0
                        
                        
                    }else if  statusMessage as! String == "aboutus_page" {
                        
                        let storyboard = UIStoryboard(name:"Main", bundle: nil)
                        let myAppoint = storyboard.instantiateViewController(withIdentifier: "AboutUsViewController") as? AboutUsViewController
                         myAppoint?.from = "notifi"
                        var viewcontroller = UIApplication.shared.keyWindow?.rootViewController
                        let navigation = UINavigationController.init(rootViewController: myAppoint!)
                        navigation.modalPresentationStyle = .overCurrentContext
                        while ((viewcontroller?.presentedViewController) != nil)
                        {
                        viewcontroller = viewcontroller?.presentedViewController
                        }
                        viewcontroller?.present(navigation, animated: true, completion: nil)
                        UIApplication.shared.applicationIconBadgeNumber = 0
                        
                        
                    
                    }
//                    else if  statusMessage as! String == "chat_page" {
//
//                     let storyboard = UIStoryboard(name:"Main", bundle: nil)
//                     let myAppoint = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController
//                             myAppoint?.selectedIndex = 3
//                     var viewcontroller = UIApplication.shared.keyWindow?.rootViewController
//                     let navigation = UINavigationController.init(rootViewController: myAppoint!)
//                     navigation.modalPresentationStyle = .overCurrentContext
//                     while ((viewcontroller?.presentedViewController) != nil)
//                     {
//                     viewcontroller = viewcontroller?.presentedViewController
//                     }
//                     viewcontroller?.present(navigation, animated: true, completion: nil)
//                     UIApplication.shared.applicationIconBadgeNumber = 0
//
//
//
//                    }
//                    else if  statusMessage as! String == "about-us-hindi" {
//
//                        let storyboard = UIStoryboard(name:"Main", bundle: nil)
//                        let myAppoint = storyboard.instantiateViewController(withIdentifier: "AboutUsViewController") as? AboutUsViewController
//                        myAppoint?.from = "notifi"
//                        var viewcontroller = UIApplication.shared.keyWindow?.rootViewController
//                        let navigation = UINavigationController.init(rootViewController: myAppoint!)
//                        navigation.modalPresentationStyle = .overCurrentContext
//                        while ((viewcontroller?.presentedViewController) != nil)
//                        {
//                        viewcontroller = viewcontroller?.presentedViewController
//                        }
//                        viewcontroller?.present(navigation, animated: true, completion: nil)
//                        UIApplication.shared.applicationIconBadgeNumber = 0
//
//
//                    }
//                    else if  statusMessage as! String == "chat_with_whats_app" {
//
//                        let storyboard = UIStoryboard(name:"Main", bundle: nil)
//                        let myAppoint = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController
//                                myAppoint?.selectedIndex = 3
//                        var viewcontroller = UIApplication.shared.keyWindow?.rootViewController
//                        let navigation = UINavigationController.init(rootViewController: myAppoint!)
//                        navigation.modalPresentationStyle = .overCurrentContext
//                        while ((viewcontroller?.presentedViewController) != nil)
//                        {
//                        viewcontroller = viewcontroller?.presentedViewController
//                        }
//                        viewcontroller?.present(navigation, animated: true, completion: nil)
//                        UIApplication.shared.applicationIconBadgeNumber = 0
//
//
//                    }
//                    else if  statusMessage as! String == "profile_page" {
//
//
//                        let storyboard = UIStoryboard(name:"Main", bundle: nil)
//                        let myAppoint = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController
//                        myAppoint?.from = "notifi"
//                        var viewcontroller = UIApplication.shared.keyWindow?.rootViewController
//                        let navigation = UINavigationController.init(rootViewController: myAppoint!)
//                        navigation.modalPresentationStyle = .overCurrentContext
//                        while ((viewcontroller?.presentedViewController) != nil)
//                        {
//                        viewcontroller = viewcontroller?.presentedViewController
//                        }
//                        viewcontroller?.present(navigation, animated: true, completion: nil)
//                        UIApplication.shared.applicationIconBadgeNumber = 0
//
//
//                    }
                    else if  statusMessage as! String == "notification" {
                           
                      
                      

                        let storyboard = UIStoryboard(name:"Main", bundle: nil)
                        let myAppoint = storyboard.instantiateViewController(withIdentifier: "NotificationViewController") as? NotificationViewController
                        myAppoint?.from = "notifi"
                        myAppoint?.Titletxt = titleString
                       // if let img = aps["image"]  as? String {
                            
                        if let img = fcm_options!["image"]  as? String {
                            
                            print("Notificationimg = \(img)")
                            myAppoint?.Img = img
                        }
                        myAppoint?.text = bodyString
                        var viewcontroller = UIApplication.shared.keyWindow?.rootViewController
                        let navigation = UINavigationController.init(rootViewController: myAppoint!)
                        navigation.modalPresentationStyle = .overCurrentContext
                        while ((viewcontroller?.presentedViewController) != nil)
                        {
                        viewcontroller = viewcontroller?.presentedViewController
                        }
                        viewcontroller?.present(navigation, animated: true, completion: nil)
                        UIApplication.shared.applicationIconBadgeNumber = 0
                                    
                          
                    }else if  statusMessage as! String == "register_course" {
                                    
                        
                        
                        
                        let storyboard = UIStoryboard(name:"Main", bundle: nil)
                        let myAppoint = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController
                        myAppoint?.from = "notifi"
                    
                        var viewcontroller = UIApplication.shared.keyWindow?.rootViewController
                        let navigation = UINavigationController.init(rootViewController: myAppoint!)
                        navigation.modalPresentationStyle = .overCurrentContext
                        while ((viewcontroller?.presentedViewController) != nil)
                        {
                        viewcontroller = viewcontroller?.presentedViewController
                        }
                        viewcontroller?.present(navigation, animated: true, completion: nil)
                        UIApplication.shared.applicationIconBadgeNumber = 0
                                    
                        
                    }
                    else {
                         
                       
                    let storyboard = UIStoryboard(name:"Main", bundle: nil)
                    let myAppoint = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController
                    var viewcontroller = UIApplication.shared.keyWindow?.rootViewController
                    let navigation = UINavigationController.init(rootViewController: myAppoint!)
                    navigation.modalPresentationStyle = .overCurrentContext
                    while ((viewcontroller?.presentedViewController) != nil)
                    {
                        viewcontroller = viewcontroller?.presentedViewController
                    }
                    viewcontroller?.present(navigation, animated: true, completion: nil)
                    UIApplication.shared.applicationIconBadgeNumber = 0
                         
                         
                         
                     }
    
                    
                   }
 
            
               }
        
 
        
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }

        // Print full message.
        print(userInfo)
        print("userInfo1 = \(userInfo)")

        
        //You can here parse it, and redirect.
        for key in userInfo.keys {
      
            //Constants.setPrint("\(key): \(userInfo[key])")
        
             print("key = \(key)")
           
        }
        completionHandler()
    }
    
}
