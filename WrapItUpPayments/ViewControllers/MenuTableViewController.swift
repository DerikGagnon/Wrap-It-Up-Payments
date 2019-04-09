//
//  ItemTableViewController.swift
//  FoodTruckPOS
//
//  Created by Derik Gagnon on 12/3/18.
//  Copyright © 2018 Derik Gagnon. All rights reserved.
//

import UIKit

// Delegate to send items to the order table
protocol MenuDatabaseDelegate: class {
    func addItem(_ item: MenuItem)
}

class MenuTableViewController: UITableViewController {
    
    // categories for the types of items - used for comparisons
    let categories = ["Beverages", "Appetizers", "Soups Or Salads", "Entrees", "Kid's Entrees", "Desserts"]
    
    var orderViewController: YourOrderViewController!
    var menuItemList: [MenuItem] = []
    weak var cellDatabaseDelegate: MenuDatabaseDelegate!
    var detailItemTemp = MenuItem()
    
    // arrays for each type of item
    var beverages: [MenuItem] = []
    var appetizers: [MenuItem] = []
    var soupsOrSalads: [MenuItem] = []
    var entrees: [MenuItem] = []
    var kidsEntrees: [MenuItem] = []
    var desserts: [MenuItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
         // 250 is a good height for visual appeal
        tableView.rowHeight = 250
        
        // reset all of the lists to prevent double adds
        self.beverages.removeAll()
        self.appetizers.removeAll()
        self.soupsOrSalads.removeAll()
        self.entrees.removeAll()
        self.kidsEntrees.removeAll()
        self.desserts.removeAll()
        
        // checks types of each item
        for item in menuItemList {
            //print(item.name)
            var choice = 0
            for cat in categories {
                if cat == item.type {
                    choice = categories.firstIndex(of: cat)!
                }
            }
            
            // adds item to correct list
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
                print("No match in load")
            }
        }

        if let splitVC = self.splitViewController {
            //Set the link to the master splitViewController
            orderViewController = splitVC.viewControllers[0] as? YourOrderViewController
//            navController.topViewController!.navigationItem.leftBarButtonItem = splitVC.displayModeButtonItem
//            // create a link the order view controller so we can access functions
//            orderViewController = navController.viewControllers[0] as? YourOrderViewController
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ItemDetail") {
            // pass data to next view
            let detailVC = segue.destination as? ItemDetailViewController
            //print(self.detailItemTemp.name)
            detailVC?.item = self.detailItemTemp
        }
    }

    // MARK: - Table view data source
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // Have 6 categories so 6 sections
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // one row per section for collectionview
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! MenuItemCell
        
        // set the delegate to the cell so we can use didTapCell
        cell.cellDelegate = self
        cell.rowIndex = indexPath.section
        
        // sets correct cell list to the correct category
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
            print("No match in cell dequeue")
        }
        cell.collectionView.reloadData()
        return cell
    }

}

// adds item to order table and refresh the UI of the order view
extension MenuTableViewController: MenuRowDelegate {
    func didTapCell(_ item: MenuItem) {
        self.detailItemTemp = item
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        //let detailVC = ItemDetailViewController() //your view controller
        //print(self.detailItemTemp.name)
        //detailVC.item = self.detailItemTemp
        //print(detailVC.item.name)
        //self.present(detailVC, animated: true, completion: nil)
//        self.navigationController?.pushViewController(detailVC, animated: true)
        //performSegue(withIdentifier: "ItemDetail", sender: self)
        // Instantiate New Controller
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "menuScene") as! ItemDetailViewController
        
        // Pass Data to Controller
        newViewController.item = item
        //newViewController.orderViewController = orderViewController
        
        
        
        // Present New View
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
}
