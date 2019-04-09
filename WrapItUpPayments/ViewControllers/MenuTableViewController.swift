//
//  ItemTableViewController.swift
//  FoodTruckPOS
//
//  Created by Derik Gagnon on 12/3/18.
//  Copyright © 2018 Derik Gagnon. All rights reserved.
//

import UIKit

protocol MenuDatabaseDelegate: class {
    func addItem(_ item: MenuItem)
}

class MenuTableViewController: UITableViewController {
    
    let categories = ["Beverages", "Appetizers", "Soups Or Salads", "Entrees", "Kid's Entrees", "Desserts"]
    
    var orderViewController: YourOrderViewController!
    var menuItemList: [MenuItem] = []
    weak var cellDatabaseDelegate: MenuDatabaseDelegate!
    var beverages: [MenuItem] = []
    var appetizers: [MenuItem] = []
    var soupsOrSalads: [MenuItem] = []
    var entrees: [MenuItem] = []
    var kidsEntrees: [MenuItem] = []
    var desserts: [MenuItem] = []
//    var activityIndicator: UIActivityIndicatorView!
    
//    enum Categories: Int {
//        case Beverages = 0, Appetizers = 1, SoupsSalads = 2, Entrees = 3, Kids = 4, Desserts = 5
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 250
        
        self.beverages.removeAll()
        self.appetizers.removeAll()
        self.soupsOrSalads.removeAll()
        self.entrees.removeAll()
        self.kidsEntrees.removeAll()
        self.desserts.removeAll()
        
        for item in menuItemList {
            print(item.name)
            var choice = 0
            for cat in categories {
                if cat == item.type {
                    choice = categories.firstIndex(of: cat)!
                }
            }
            switch choice {
            case 0:
                self.beverages.append(item)
                break
            case 1:
                self.appetizers.append(item)
                break
            case 2:
                self.soupsOrSalads.append(item)
                break
            case 3:
                self.entrees.append(item)
                break
            case 4:
                self.kidsEntrees.append(item)
                break
            case 5:
                self.desserts.append(item)
                break
            default:
                print("No match in addItem protocol")
            }
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
    
    override func viewDidAppear(_ animated: Bool) {
        
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

        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! MenuItemCell
        cell.cellDelegate = self
        //self.cellDatabaseDelegate = cell
        cell.rowIndex = indexPath.section
        switch indexPath.section {
        case 0:
            cell.beverages = self.beverages
            break
        case 1:
            cell.appetizers = self.appetizers
            break
        case 2:
            cell.soupsOrSalads = self.soupsOrSalads
            break
        case 3:
            cell.entrees = self.entrees
            break
        case 4:
            cell.kidsEntrees = self.kidsEntrees
            break
        case 5:
            cell.desserts = self.desserts
            break
        default:
            print("No match in addItem protocol")
        }
        cell.collectionView.reloadData()
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
