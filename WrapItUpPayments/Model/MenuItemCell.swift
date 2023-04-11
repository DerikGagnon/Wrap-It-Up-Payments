//
//  Item.swift
//  FoodTruckPOS
//
//  Created by Derik Gagnon on 12/3/18.
//  Copyright © 2018 Derik Gagnon. All rights reserved.
//

import UIKit

protocol MenuRowDelegate: AnyObject {
    func didTapCell(_ item: MenuItem)
}

class MenuItemCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // categories for comparison
    let categories = ["Beverages", "Appetizers", "Soups Or Salads", "Entrees", "Kid's Entrees", "Desserts"]
    
    // Items for this specific cell
    var menuItems: [MenuItem] = []
    
    var cellDelegate: MenuRowDelegate!
    var rowIndex = 0
    @IBOutlet var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.reloadData()
        
    }
    
    // Keeps cells in memory so they aren't overwritten
    override func prepareForReuse() {
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! MenuCollectionCell
        
        // Add items to cells
//        cell.itemImage?.sd_setImage(with: menuItems[indexPath.item].image)
        cell.itemName?.text = menuItems[indexPath.item].name
        let formattedPrice = String(format: "$%.2f", menuItems[indexPath.item].price)
        cell.itemPrice?.text = formattedPrice
        
        // Sets text wrapping for better visuals
        // https://stackoverflow.com/questions/3931838/how-to-write-multiple-lines-in-a-label
        cell.itemName?.lineBreakMode = .byWordWrapping
        cell.itemName?.numberOfLines = 0
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Choose which index is correct
        let clickedIndex = menuItems[indexPath.item]
        
        // Sends correct item to the order table for payments
        self.cellDelegate!.didTapCell(clickedIndex)
        
    }
    
}
