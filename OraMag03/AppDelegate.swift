//
//  AppDelegate.swift
//  OraMag03
//
//  Created by Chris Muir on 4/01/2016.
//  Copyright © 2016 Chris Muir. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        let settings = UIUserNotificationSettings(types: ([.badge, .sound, .alert]), categories: nil)
        
        application.registerUserNotificationSettings(settings)
    
        
        return true
    }
    
    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        
        application.registerForRemoteNotifications()
        
        print("reg user notifcaiton 3 ")
        //registerUserNotificationSettings()

    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("reg user notifcaiton 2 ..| \(deviceToken)")
        
        var token = ""
        for i in 0..<deviceToken.count {
            token = token + String(format: "%02.2hhx", arguments: [deviceToken[i]])
        }
        print("Deive token : \(token)")
        
        Utility.deviceIdStore.deviceid = deviceToken
        
        //let mcsMbeManager: OMCMobileBackendManager =
            //OMCMobileBackendManager.shared()
        
        //let mcsMbe: OMCMobileBackend = mcsMbeManager.defaultMobileBackend
        
       // let mcsAuthorization: OMCAuthorization = mcsMbe.authorization
        
        //let loginError: NSError! = mcsAuthorization
            //.authenticate("joedoe", password: "12@Testing") as NSError!
        
        //print("---------------login---\(loginError)......\(mcsAuthorization)")

       // if loginError == nil {
         
            //registerUserNotificationSettings(deviceToken : deviceToken)
       // }
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("reg user notifcaiton error \(error) ")

    }
    
    func registerUserNotificationSettings(deviceToken : Data){
        
        print("reg user notifcaiton fun called")
        
        // Get notifications sdk object
        let mcsMbeManager: OMCMobileBackendManager =
            OMCMobileBackendManager.shared()
        
        let mcsMbe: OMCMobileBackend = mcsMbeManager.defaultMobileBackend
        
       // mcsMbe.notifications()

        let notifications = mcsMbe.notifications()
        
        // Get device token first, and assign it here
        let deviceTokenData:NSData! = deviceToken as NSData!;
        
        // Register device token with MCS server using notifications sdk
        notifications?.register(forNotifications: deviceTokenData as Data!, onSuccess: { (response: Any!) in
            
            NSLog("Device token registered successfully on MCS server");
            
            DispatchQueue.main.async() {
                // Update UI here
            }
            
        }) { (error) in
            
            print("Push notification..Error: %@", error?.localizedDescription);
        };
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        
        var msgString : String?
        
        if let aps = userInfo["aps"] as? NSDictionary {
            
            // badge
            //print("\(userInfo)...user badge \(aps["badge"] as! NSString)")
            
            UIApplication.shared.applicationIconBadgeNumber = 1
            
            if let alert = aps["alert"] as? NSDictionary {
                if let message = alert["message"] as? NSString {
                    //Do stuff
                    print("Notification NSDictionary ..\(message)")
                    msgString = message as String
                }
            } else if let alert = aps["alert"] as? NSString {
                //Do stuff
                print("Notification string ..\(alert)")

                   msgString = alert as String
            }
        }
        
        
        let notifiAlert = UIAlertView()
        //var NotificationMessage : AnyObject? =  userInfo["alert"]
        notifiAlert.title = "Push Notificaiton"
        notifiAlert.message = msgString!
        notifiAlert.addButton(withTitle: "OK")
        notifiAlert.show()


    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

