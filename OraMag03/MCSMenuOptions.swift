//
//  MCSMenuOptions.swift
//  OraMag03
//
//  Created by bruno on 10/25/16.
//  Copyright © 2016 Chris Muir. All rights reserved.
//

import UIKit

class MCSMenuOptions: UIViewController , UITableViewDelegate, UITableViewDataSource {

    var arrMenuOption : [String]!
    
    @IBOutlet weak var tableviewMenu: UITableView!
    
    override func viewDidLoad() {
        
        self.tableviewMenu.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        arrMenuOption = ["Storage API", "Custom API", "Analytics"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Returns number of objects in collection to display in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // <<MCS CODE #04>>
        // <<Add code to return number of objects in OraMagSharedCollection>>
        return self.arrMenuOption.count
        // return 0;
    }
    
    // Executed for each cell in table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableviewMenu.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!
        
        // <<MCS CODE #05>>
        // <<Add code to populate each cell's text label with OMCStorageObject ID>>
        cell.textLabel?.text = self.arrMenuOption[indexPath.row]
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("get want i \(indexPath.row)")
        
        let indexStr = self.arrMenuOption[indexPath.row]

        if indexPath.row == 0 {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let dashBoardMyVC = storyboard.instantiateViewController(withIdentifier: "StorageViewController") as? StorageViewController
            self.navigationController?.pushViewController(dashBoardMyVC!, animated: true)

        }
        
        if indexPath.row == 2 {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let dashBoardMyVC = storyboard.instantiateViewController(withIdentifier: "analyticsSBID") as? AnalyticsView
            self.navigationController?.pushViewController(dashBoardMyVC!, animated: true)
            
        }

        
    }

    @IBAction func logoutButton(_ sender: AnyObject) {
        
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
