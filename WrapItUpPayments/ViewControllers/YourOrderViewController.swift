//
//  YourOrderViewController.swift
//  FoodTruckPOS
//
//  Created by Derik Gagnon on 2/5/19.
//  Copyright © 2019 Derik Gagnon. All rights reserved.
//

import UIKit
import SquarePointOfSaleSDK

class YourOrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var subtotalLabel: UILabel!
    @IBOutlet var taxLabel: UILabel!
    @IBOutlet var totalLabel: UILabel!
    
    @IBOutlet weak var OrderButton: UIButton!
    
    // Launch the square application when button is pressed
    @IBAction func OrderButtonPressed(_ sender: UIButton) {
        // Replace with your app's URL scheme.
        let callbackURL = URL(string: "wrapitup://")!
        
        // Your client ID is the same as your Square Application ID.
        // Note: You only need to set your client ID once, before creating your first request.
        SCCAPIRequest.setClientID("sq0idp-LD09GWHOBMDC48jYiDcY7g")

        do {
            // Specify the amount of money to charge.
            let roundedMoney = String(format: "%.2f", total)
            let money = try SCCMoney(amountCents: Int(Double(roundedMoney)!*100), currencyCode: "USD")
            
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
                    returnAutomaticallyAfterPayment: true
            )
            
            // Open Point of Sale to complete the payment.
            try SCCAPIConnection.perform(apiRequest)
            
        // error from square about payments
        } catch let error as NSError {
            print(error.localizedDescription)
            return
        }
        
        // go back to place order screen
        self.dismiss(animated: true, completion: nil)
    }
    
    var orderItemsArray: [MenuItem] = []
    var subtotal: Float32 = 0
    var tax: Float32 = 0
    var total: Float32 = 0
    
    @IBOutlet var orderTable: UITableView!
    
    //Refreshes the OrderViewController Prices
    func refreshUI() {
        // Refresh the table data
        self.orderTable.reloadData()
        loadViewIfNeeded()
        
        // Prevent button press when cart is empty
        if self.orderTable.visibleCells.isEmpty {
            self.OrderButton.isEnabled = false
        } else {
            self.OrderButton.isEnabled = true
        }
        
        // Format subtotal, tax, and total to be strings
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
        
        // Prevent pressing button when there is nothing in the cart
        self.OrderButton.isEnabled = false
        
        // self.orderTable.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Dynamically change number of rows based on array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(String(orderItemsArray.count))
        return orderItemsArray.count
    }
    
    // Set the cells in the table with the item data.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! YourOrderTableCell
        cell.nameLabel?.text = orderItemsArray[indexPath.row].name
        let formattedPrice = String(format: "$%.2f", orderItemsArray[indexPath.row].price)
        cell.priceLabel?.text = formattedPrice
        return cell
    }
    
}
