//
//  ItemDetailViewController.swift
//  Wrap It Up Payments
//
//  Created by Derik Gagnon on 4/9/19.
//  Copyright © 2019 Derik Gagnon. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController {

    @IBOutlet weak var PriceLabel: UILabel!
    @IBOutlet weak var ItemImageView: UIImageView!
    @IBOutlet weak var AllergiesLabel: UILabel!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var DescriptionLabel: UILabel!
    
    
    @IBAction func AddOrderButton(_ sender: UIButton) {
        // Send item to the order table
        orderViewController?.orderItemsArray.append(item)
        orderViewController?.refreshUI()

        // remove reference to the nav controller so it doesn't dismiss everything
        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    var item = MenuItem()
    var orderViewController: YourOrderViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set all the labels and images to data from the menu item
        let formattedPrice = String(format: "$%.2f", item.price)
        PriceLabel.text = formattedPrice
        ItemImageView.sd_setImage(with: item.image)
        AllergiesLabel.text = item.allergies
        NameLabel.text = item.name
        DescriptionLabel.text = item.desc
        
        // Word wrapping for the table view controller
        // https://stackoverflow.com/questions/3931838/how-to-write-multiple-lines-in-a-label
        NameLabel.lineBreakMode = .byWordWrapping
        NameLabel.numberOfLines = 0
        
        DescriptionLabel.lineBreakMode = .byWordWrapping
        DescriptionLabel.numberOfLines = 0
        
        // Initialize the viewcontroller for the order
        if let splitVC = self.splitViewController {
            //Set the link to the master splitViewController
            orderViewController = splitVC.viewControllers[0] as? YourOrderViewController
        }
    }

}
