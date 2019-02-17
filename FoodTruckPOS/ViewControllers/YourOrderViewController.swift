//
//  YourOrderViewController.swift
//  FoodTruckPOS
//
//  Created by Derik Gagnon on 2/5/19.
//  Copyright © 2019 Derik Gagnon. All rights reserved.
//

import UIKit

class YourOrderViewController: UIViewController {
    
    @IBOutlet var subtotalLabel: UILabel!
    @IBOutlet var taxLabel: UILabel!
    @IBOutlet var totalLabel: UILabel!
    
    var orderItemsArray: [MenuItem] = []
    var subtotal: Float32 = 0
    var tax: Float32 = 0
    var total: Float32 = 0
    
    var itemToAdd: MenuItem? {
        didSet {
            print("We made it")
            orderItemsArray.append(itemToAdd!)
            refreshUI()
        }
    }
    
    func refreshUI() {
        print("In refresh UI")
        loadViewIfNeeded()
        subtotal = orderItemsArray.map({$0.price}).reduce(0, +)
        subtotalLabel.text = String(subtotal)
        tax = subtotal * 0.06
        taxLabel.text = String(tax)
        total = subtotal + tax
        totalLabel.text = String(total)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}


extension YourOrderViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return orderItemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! YourOrderTableCell
        cell.nameLabel?.text = orderItemsArray[indexPath.row].name
        cell.priceLabel?.text = String(orderItemsArray[indexPath.row].price)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 160
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//
//    }
    
}

extension YourOrderViewController: ItemAddedDelegate {
    func ItemAdded(_ newItem: MenuItem) {
        itemToAdd = newItem
    }
}
