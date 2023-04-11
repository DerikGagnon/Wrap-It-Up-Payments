//
//  PlaceOrderViewController.swift
//  Wrap It Up Payments
//
//  Created by Derik Gagnon on 4/8/19.
//  Copyright © 2019 Derik Gagnon. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class PlaceOrderViewController: UIViewController {
    
    var ref: DatabaseReference!
    var itemKey = ""
    var itemList: [MenuItem] = []
    var typeList: [String] = []
    
    func downloadData() {
        // reference to database
        ref = Database.database().reference()
        // Get a reference to the storage service using the default Firebase App
        let storage = Storage.storage()
        
        // Create a storage reference from our storage service
        let storageRef = storage.reference()
        let userID = Auth.auth().currentUser?.uid
        
        // Get the items from the database
        ref.child("user-items").child(userID!).observeSingleEvent(of: .value, with: { snapshot in
            
            // loop through json from database
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                // temp MenuItem to store dictionary aspects to
                let tempItem = MenuItem()
                
                // guard for if there is no item
                guard let childDict = child.value as? [String: Any] else {
                    continue
                }
                // get name
                let name = childDict["name"] as! String
                tempItem.name = name
                
                // get type
                let type = childDict["itemType"] as! String
                tempItem.type = type
                
                var found = false
                
                // Get categories ready for MenuTableViewController
                if self.typeList.isEmpty {
                    self.typeList.append(type)
                    found = true
                } else {
                    // Check if we already have a type in our list
                    for item in self.typeList {
                        if type == item {
                            found = true
                        }
                    }
                }
                
                // Adds new type if not in the list already
                if !found {
                    self.typeList.append(type)
                }
                
                // get price and format to float
                let price = childDict["price"] as! String
                let numberFormatter = NumberFormatter()
                let number = numberFormatter.number(from: price)
                let numberFloatValue = number?.floatValue
                tempItem.price = numberFloatValue!
                
                // get allergies
                let allergies = childDict["itemAllergies"] as! String
                tempItem.allergies = allergies
                
                // get description
                let description = childDict["description"] as! String
                tempItem.desc = description
                
                // get image Reference
                let imageRef = childDict["imageUrl"] as! String
                let reference = storageRef.child(imageRef)
                tempItem.image = reference
                
                // append to list to send later
                self.itemList.append(tempItem)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        // Enable after items are downloaded
        self.OrderPlacedButton.isEnabled = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Destination is split view controller - must navigate through
        if let splitVC = segue.destination as? UISplitViewController {
            // Detail view is the second part of nav controller - [1]
            let navController = splitVC.viewControllers[1] as! UINavigationController
            let menuTable = navController.viewControllers[0] as? MenuTableViewController
            
            print(typeList)
            
            // set menu list to current list
            menuTable?.menuItemList.removeAll()
            menuTable?.categoriesNames.removeAll()
            print(self.itemList.count)
            menuTable?.menuItemList = self.itemList
            
            // Uncomment these line to make the sections dependent on the database - currently not supported for more than 6 types
//            menuTable?.categoriesAll.removeAll()
//            menuTable?.categoriesAll = self.typeList.sorted()
        }
    }
    
    
    @IBOutlet weak var OrderPlacedButton: UIButton!
    
    @IBAction func OrderPlacedButtonPressed(_ sender: UIButton) {
        // Go to menu view controller
        performSegue(withIdentifier: "OrderToMenu", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.OrderPlacedButton.isEnabled = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // reset the array
        self.itemList.removeAll()
        self.typeList.removeAll()
        
        // Download in did appear so it can be reset after payment
        self.downloadData()
    }
    
}
