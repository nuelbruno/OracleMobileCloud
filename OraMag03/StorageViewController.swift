//
//  StorageViewController.swift
//  OraMag03
//
//  Created by Chris Muir on 4/01/2016.
//  Copyright © 2016 Chris Muir. All rights reserved.
//

import UIKit

class StorageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    // <<MCS CODE #02>>
    // <<Add variable to hold access to OraMagSharedCollections objects once retrieved>>
    var mcsLocalCollection: [OMCStorageObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // <<MCS CODE #03>>
        // <<Add code to retrieve MCS collection OraMagSharedCollection when page loaded>>
        let mcsMbeManager: OMCMobileBackendManager =
            OMCMobileBackendManager.shared()
        let mcsMbe: OMCMobileBackend = mcsMbeManager.defaultMobileBackend
        let mcsStorage: OMCStorage = mcsMbe.storage()
        let mcsRemoteCollection: OMCStorageCollection = mcsStorage
            .getCollection("OraMagSharedCollection")
        mcsLocalCollection = mcsRemoteCollection.get(0, withLimit: 9999,
                                                     getAllObjects: true) as AnyObject as! [OMCStorageObject]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Returns number of objects in collection to display in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // <<MCS CODE #04>>
        // <<Add code to return number of objects in OraMagSharedCollection>>
        return self.mcsLocalCollection.count
        // return 0;
    }
    
    // Executed for each cell in table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!
        
        // <<MCS CODE #05>>
        // <<Add code to populate each cell's text label with OMCStorageObject ID>>
        cell.textLabel?.text = self.mcsLocalCollection[indexPath.row].id
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("get want i )")
        
        let mcsObject: OMCStorageObject = self
            .mcsLocalCollection[indexPath.row]
        let contentType: String = mcsObject.contentType
        
        if contentType == "application/json" {
            
            let title: String = mcsObject.id
            let message: String = String(data: mcsObject.getPayloadData(),
                                         encoding: String.Encoding.utf8)!
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // Include table view cell swipeable action View to show OMCStorageObject contents in alert
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let viewAction = UITableViewRowAction(style: .normal, title: "View") { action, index in
            
            // <<MCS CODE #06>>
            // <<Add code to retrieve OMCStorageObject based index, + content type>>
            
            // Being lazy: only works with JSON objects returned from MCS
            // You can add logic to handle other OMCStorage types
            if 1 == 1 {
                // if contentType == "application/json" {
                
                // <<MCS CODE #07>>
                // <<Retreive omcObject ID for alert title + payload for message>>
                
                let title = "title"
                let message = "message"
                
                let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        viewAction.backgroundColor = UIColor.lightGray
        
        return [viewAction]
    }
    
    // Needed to display swipeable cell options; doesn't require any code
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    }
    
    // Needed to determine which cells include swipeable option; all by default for our demo
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    @IBAction func doLogout(_ sender: AnyObject) {
        
        // <<MCS CODE #08>>
        // <<Add code to logout of MCS>>
        
        let mcsMbeManager: OMCMobileBackendManager =
            OMCMobileBackendManager.shared()
        let mcsMbe: OMCMobileBackend = mcsMbeManager.defaultMobileBackend
        let mcsAuthorization: OMCAuthorization = mcsMbe.authorization
        let logoutError: NSError! = mcsAuthorization.logout() as NSError!
   
         print("logout error msg \(logoutError)")
        
        if logoutError == nil {
            // if logoutError == nil {
            self.performSegue(withIdentifier: "GoLogin", sender: nil)
        }
    }
}
