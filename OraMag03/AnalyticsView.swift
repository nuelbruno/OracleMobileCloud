//
//  AnalyticsView.swift
//  OraMag03
//
//  Created by bruno on 10/25/16.
//  Copyright © 2016 Chris Muir. All rights reserved.
//

import UIKit

class AnalyticsView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let mcsMbeManager: OMCMobileBackendManager =
            OMCMobileBackendManager.shared()
        let mcsMbe: OMCMobileBackend = mcsMbeManager.defaultMobileBackend
        //let mcsStorage: OMCStorage = mcsMbe.storage()
        let mcsAnalytics = mcsMbe.analytics()
        
        let eventProperty : [String : Any] = ["Parts Location" : "ON Truck",
                             "Drive Time" : "Less than 5 min",
                             "onSite Time" : "More than 30 min"]
        
        
     
        mcsAnalytics?.logEvent("Work order on Hold", properties: eventProperty)
        
        mcsAnalytics?.flush()
        
        let notifiAlert = UIAlertView()
        notifiAlert.title = "Analytics"
        notifiAlert.message = "Analytics send to MCS"
        notifiAlert.addButton(withTitle: "OK")
        notifiAlert.show()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
