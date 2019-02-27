//
//  YourOrderViewController.swift
//  FoodTruckPOS
//
//  Created by Derik Gagnon on 2/5/19.
//  Copyright © 2019 Derik Gagnon. All rights reserved.
//

import UIKit

class YourOrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var subtotalLabel: UILabel!
    @IBOutlet var taxLabel: UILabel!
    @IBOutlet var totalLabel: UILabel!
    
    
    @IBAction func OrderButtonPressed(_ sender: UIButton) {
        //Implement Square API HERE
    }
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let EditVC = storyboard?.instantiateViewController(withIdentifier: "EditItemViewController") as! EditItemViewController
//        present(EditVC, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let editVC = segue.destination as! EditItemViewController
        let indexPath = orderTable.indexPathForSelectedRow!
        editVC.NameLabel?.text = orderItemsArray[indexPath.row].name
    }
    
}
