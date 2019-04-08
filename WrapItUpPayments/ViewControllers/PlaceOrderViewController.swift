//
//  PlaceOrderViewController.swift
//  Wrap It Up Payments
//
//  Created by Derik Gagnon on 4/8/19.
//  Copyright © 2019 Derik Gagnon. All rights reserved.
//

import UIKit
import Firebase

class PlaceOrderViewController: UIViewController {
    
    var ref: DatabaseReference!
    var itemKey = ""
//    weak var databaseDelegate: DatabaseDelegate!
    var itemList: [MenuItem] = []
    
    func downloadData() {
        ref = Database.database().reference()
        //var tempItemList: [MenuItem] = []
        
        let userID = Auth.auth().currentUser?.uid
        ref.child("user-items").child(userID!).observeSingleEvent(of: .value, with: { snapshot in
            print(snapshot.value)
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let tempItem = MenuItem(name: "", price: 0.00, image: "", type: "")
                guard let childDict = child.value as? [String: Any] else {
                    continue
                }
                let name = childDict["name"] as! String
                //print(name)
                tempItem.name = name
                let type = childDict["itemType"] as! String
              //  print(type)
                tempItem.type = type
                let price = childDict["price"] as! String
//                print(price)
                let numberFormatter = NumberFormatter()
                let number = numberFormatter.number(from: price)
                let numberFloatValue = number?.floatValue
                tempItem.price = numberFloatValue!
                let allergies = childDict["itemAllergies"] as! String
//                print(allergies)
                tempItem.allergies = allergies
                let description = childDict["description"] as! String
//                print(description)
                tempItem.desc = description
                tempItem.image = ""
                //tempItemList.append(tempItem)
                self.itemList.append(tempItem)
                print(self.itemList.count)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        //        self.cellDatabaseDelegate.addItem(tempItem)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(segue.destination)
        if let splitVC = segue.destination as? UISplitViewController {
            let navController = splitVC.viewControllers[1] as! UINavigationController
            let menuTable = navController.viewControllers[0] as? MenuTableViewController
            menuTable?.menuItemList = self.itemList
            print(self.itemList)
        }
    }
    @IBAction func OrderPlacedButtonPressed(_ sender: UIButton) {
        print("BETTER BE DOIN THAT PERFORM BITCH")
        performSegue(withIdentifier: "OrderToMenu", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.downloadData()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
