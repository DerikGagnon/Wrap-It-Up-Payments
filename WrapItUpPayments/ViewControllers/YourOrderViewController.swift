//
//  YourOrderViewController.swift
//  FoodTruckPOS
//
//  Created by Derik Gagnon on 2/5/19.
//  Copyright © 2019 Derik Gagnon. All rights reserved.
//

import UIKit
import SquarePointOfSaleSDK

protocol EditRowDelegate: class {
    func didTapCell(_ item: MenuItem)
}

class YourOrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var subtotalLabel: UILabel!
    @IBOutlet var taxLabel: UILabel!
    @IBOutlet var totalLabel: UILabel!
    
    
    @IBAction func OrderButtonPressed(_ sender: UIButton) {
        //Implement Square API HERE
        // Replace with your app's URL scheme.
        let callbackURL = URL(string: "wrapitup://")!
        
        // Your client ID is the same as your Square Application ID.
        // Note: You only need to set your client ID once, before creating your first request.
        SCCAPIRequest.setClientID("sq0idp-LD09GWHOBMDC48jYiDcY7g")

        do {
            // Specify the amount of money to charge.
            let money = try SCCMoney(amountCents: 100, currencyCode: "USD")
            
            // Create the request.
            let apiRequest =
                try SCCAPIRequest(
                    callbackURL: callbackURL,
                    amount: money,
                    userInfoString: nil,
                    locationID: nil,
                    notes: nil,
                    customerID: nil,
                    supportedTenderTypes: .card,
                    clearsDefaultFees: false,
                    returnAutomaticallyAfterPayment: false
            )
            
            // Open Point of Sale to complete the payment.
            try SCCAPIConnection.perform(apiRequest)
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    weak var cellDelegate: EditRowDelegate! = nil
    
    var orderItemsArray: [MenuItem] = []
    var subtotal: Float32 = 0
    var tax: Float32 = 0
    var total: Float32 = 0
    
    @IBOutlet var orderTable: UITableView!
    
    func refreshUI() {
        print("In refresh UI")
        self.orderTable.reloadData()
        loadViewIfNeeded()
        //let formatted = String(format: "Angle: %.2f", angle)
        subtotal = orderItemsArray.map({$0.price}).reduce(0, +)
        let formattedSubtotal = String(format: "$%.2f", subtotal)
        subtotalLabel.text = formattedSubtotal
        tax = subtotal * 0.06
        let formattedTax = String(format: "$%.2f", tax)
        taxLabel.text = formattedTax
        total = subtotal + tax
        let formattedTotal = String(format: "$%.2f", total)
        totalLabel.text = formattedTotal

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func printHello() {
        print("We made it!!")
    }
//
//    func printItemName(item: MenuItem) {
//        print(item.name)
//    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(String(orderItemsArray.count))
        return orderItemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! YourOrderTableCell
        cell.nameLabel?.text = orderItemsArray[indexPath.row].name
        cell.priceLabel?.text = String(orderItemsArray[indexPath.row].price)
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = self.orderTable.indexPathForSelectedRow!.row
        let clickedIndex = orderItemsArray[indexPath]
        let delegate = self.cellDelegate
        if segue.identifier == "EditSegue" {
            let editVC = segue.destination as? EditItemViewController
            
            print(editVC)
            print("We in prepare")
            
            delegate?.didTapCell(clickedIndex)
            
//            editVC?.NameLabel?.text = orderItemsArray[indexPath!].name
//            print(editVC?.NameLabel?.text)
        }
    }
    
}
