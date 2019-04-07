//
//  ItemTableViewController.swift
//  FoodTruckPOS
//
//  Created by Derik Gagnon on 12/3/18.
//  Copyright © 2018 Derik Gagnon. All rights reserved.
//

import UIKit
import Firebase

class MenuTableViewController: UITableViewController {
    
    let categories = ["Beverages", "Appetizers", "Soups Or Salads", "Entrees", "Kid's Entrees", "Desserts"]
    
    var orderViewController: YourOrderViewController!
    var ref: DatabaseReference!
    
//    enum Categories: Int {
//        case Beverages = 0, Appetizers = 1, SoupsSalads = 2, Entrees = 3, Kids = 4, Desserts = 5
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 250
        ref = Database.database().reference()
        
        let userID = Auth.auth().currentUser?.uid
        ref.child("user-items").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            print(value)
            //let username = value?["username"] as? String ?? ""
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
        if let splitVC = self.splitViewController {
            //print("test2")
            print(splitVC.viewControllers.count)
            //Set the navController to the master splitViewController
            let navController = splitVC.viewControllers[0] as! UINavigationController
            navController.topViewController!.navigationItem.leftBarButtonItem = splitVC.displayModeButtonItem
            print(navController.viewControllers.count)
            orderViewController = navController.viewControllers[0] as? YourOrderViewController
            //orderViewController?.printHello()
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //self.tableView.register(SightsCell.self, forCellReuseIdentifier: "SightCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! MenuItemCell
        cell.cellDelegate = self
        cell.rowIndex = indexPath.section
        print(indexPath.section)
        
        return cell
    }

}

extension MenuTableViewController: MenuRowDelegate {
    func didTapCell(_ item: MenuItem) {
        print("We tapped")
        //orderViewController?.printItemName(item: item)
        orderViewController?.orderItemsArray.append(item)
        orderViewController?.refreshUI()
    }
}
