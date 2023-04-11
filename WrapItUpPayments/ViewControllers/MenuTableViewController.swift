//
//  ItemTableViewController.swift
//  FoodTruckPOS
//
//  Created by Derik Gagnon on 12/3/18.
//  Copyright © 2018 Derik Gagnon. All rights reserved.
//

import UIKit

// Delegate to send items to the order table
protocol MenuDatabaseDelegate: AnyObject {
    func addItem(_ item: MenuItem)
}

class MenuTableViewController: UITableViewController {
    
    // categories for the types of items - used for comparisons - master list for sections that can be based off of whats in the database
    var categoriesAll = ["Beverages", "Appetizers", "Soups Or Salads", "Entrees", "Kid's Entrees", "Desserts"]
    var categories: [[Any]] = [[]]
    var categoriesNames: [String] = []
    
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
        print(self.menuItemList.count)
        
        // reset all of the lists to prevent double adds
        self.beverages.removeAll()
        self.appetizers.removeAll()
        self.soupsOrSalads.removeAll()
        self.entrees.removeAll()
        self.kidsEntrees.removeAll()
        self.desserts.removeAll()
        self.categories.removeAll()
        
        for item in menuItemList {
            print(item)
            var choice = 0
            for cat in categoriesAll {
                if cat == item.type {
                    choice = categoriesAll.firstIndex(of: cat)!
                }
            }
            
            // Add Items into arrays for holding for cells
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
        
        // check which sections need to be loaded
        if !beverages.isEmpty {
            categories.append(beverages)
            categoriesNames.append(categoriesAll[0])
        }
        if !appetizers.isEmpty {
            categories.append(appetizers)
            categoriesNames.append(categoriesAll[1])
        }
        if !soupsOrSalads.isEmpty {
            categories.append(soupsOrSalads)
            categoriesNames.append(categoriesAll[2])
        }
        if !entrees.isEmpty {
            categories.append(entrees)
            categoriesNames.append(categoriesAll[3])
        }
        if !kidsEntrees.isEmpty {
            categories.append(kidsEntrees)
            categoriesNames.append(categoriesAll[4])
        }
        if !desserts.isEmpty {
            categories.append(desserts)
            categoriesNames.append(categoriesAll[5])
        }
        
        if let splitVC = self.splitViewController {
            //Set the link to the master splitViewController
            orderViewController = splitVC.viewControllers[0] as? YourOrderViewController
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ItemDetail") {
            // pass data to next view
            let detailVC = segue.destination as? ItemDetailViewController
            detailVC?.item = self.detailItemTemp
        }
    }
    
    // MARK: - Table view data source
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // Dependent on which categories need to be loaded
        return categoriesNames.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categoriesNames[section]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // one row per section for collectionview
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! MenuItemCell
        
        // set the delegate to the cell so we can use didTapCell
        cell.cellDelegate = self

        // Load cell data based on the section it is in
        cell.menuItems.removeAll()
        cell.menuItems = categories[indexPath.section] as! [MenuItem]
        cell.collectionView.reloadData()
        return cell
    }
    
}

// adds item to order table and refresh the UI of the order view
extension MenuTableViewController: MenuRowDelegate {
    func didTapCell(_ item: MenuItem) {
        self.detailItemTemp = item
        
        // Get reference to the storyboard
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "menuScene") as! ItemDetailViewController
        
        // Pass Data to Controller
        newViewController.item = item
        
        // Present New View
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
}
