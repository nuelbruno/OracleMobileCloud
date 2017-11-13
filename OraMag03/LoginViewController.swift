//
//  LoginViewController
//  OraMag03
//
//  Created by Chris Muir on 4/01/2016.
//  Copyright © 2016 Chris Muir. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func doLogin(_ sender: AnyObject) {
        
        let usernameStr: String! = usernameField.text
        let passwordStr: String! = passwordField.text
        
        if usernameStr.isEmpty || passwordStr.isEmpty {
            let alert = UIAlertController(title: "Login failed", message: "Please enter a username & password", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            // <<MCS CODE #01>>
            // <<Add logic to authenticate mobile user against MCS>>
            
            let mcsMbeManager: OMCMobileBackendManager =
                OMCMobileBackendManager.shared()
            
            let mcsMbe: OMCMobileBackend = mcsMbeManager.defaultMobileBackend
            
            //mcsMbe.notifications()
            
            let mcsAuthorization: OMCAuthorization = mcsMbe.authorization
            
            let loginError: NSError! = mcsAuthorization
                .authenticate(usernameStr, password: passwordStr) as NSError!
            
            print("---------------login---\(loginError)......\(mcsAuthorization)")
                                    
            if loginError == nil {
                
                if  Utility.deviceIdStore.deviceid != nil{
                    
                    //deviceId = "test"
                    registerUserNotificationSettings(deviceToken : Utility.deviceIdStore.deviceid!)
                    
                }else{
                    
                    pushNextMenuOption()
                }
                
                
                
                
                ///mainViewController.hideLeftView(animated: true, completionHandler: nil)
                
                //self.performSegue(withIdentifier: "GoStorageViewController", sender: nil)
                
            }else{
                
                let alert = UIAlertController(title: "Login failed", message: "Invalid username or password\(loginError)", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
            /*if 1 == 2 {
                let alert = UIAlertController(title: "Login failed", message: "Invalid username or password", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                self.performSegue(withIdentifier: "GoStorageViewController", sender: nil)
            }*/
        }
    }
    
    func pushNextMenuOption(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dashBoardMyVC = storyboard.instantiateViewController(withIdentifier: "MCSMenuSBID") as? MCSMenuOptions
        self.navigationController?.pushViewController(dashBoardMyVC!, animated: true)
        
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
                self.pushNextMenuOption()
                // Update UI here
            }
            
        }) { (error) in
            
            print("Push notification..Error: %@", error?.localizedDescription);
            let notifiAlert = UIAlertView()
            //var NotificationMessage : AnyObject? =  userInfo["alert"]
            notifiAlert.title = "Push Notificaiton"
            notifiAlert.message = "Device Token Number not registered with MCS"
            notifiAlert.addButton(withTitle: "OK")
            notifiAlert.show()
            self.pushNextMenuOption()
        };
    }

}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

