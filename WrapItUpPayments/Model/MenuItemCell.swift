//
//  Item.swift
//  FoodTruckPOS
//
//  Created by Derik Gagnon on 12/3/18.
//  Copyright © 2018 Derik Gagnon. All rights reserved.
//

import UIKit

protocol MenuRowDelegate: class {
    func didTapCell(_ item: MenuItem)
}

class MenuItemCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // categories for comparison
    let categories = ["Beverages", "Appetizers", "Soups Or Salads", "Entrees", "Kid's Entrees", "Desserts"]
    
    // item lists that we can append to
    var beverages: [MenuItem] = []
    var appetizers: [MenuItem] = []
    var soupsOrSalads: [MenuItem] = []
    var entrees: [MenuItem] = []
    var kidsEntrees: [MenuItem] = []
    var desserts: [MenuItem] = []
    
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
        // allow for dynamic sizes based on category
        switch rowIndex {
        case 0:
            return beverages.count
        case 1:
            return appetizers.count
        case 2:
            return soupsOrSalads.count
        case 3:
            return entrees.count
        case 4:
            return kidsEntrees.count
        case 5:
            return desserts.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! MenuCollectionCell
        
        // add the correct cells to the collection view depending on the section
        switch rowIndex {
        case 0:
            //Beverages
            //imageView.sd_setImage(with: reference, placeholderImage: placeholderImage)
            cell.itemImage?.sd_setImage(with: beverages[indexPath.item].image)
            cell.itemName?.text = beverages[indexPath.item].name
            let formattedPrice = String(format: "$%.2f", beverages[indexPath.item].price)
            cell.itemPrice?.text = formattedPrice
            break
        case 1:
            //Appetizers
            cell.itemImage?.sd_setImage(with: appetizers[indexPath.item].image)
            cell.itemName?.text = appetizers[indexPath.item].name
            let formattedPrice = String(format: "$%.2f", appetizers[indexPath.item].price)
            cell.itemPrice?.text = formattedPrice
            break
        case 2:
            //Soups or Salads
            cell.itemImage?.sd_setImage(with: soupsOrSalads[indexPath.item].image)
            cell.itemName?.text = soupsOrSalads[indexPath.item].name
            let formattedPrice = String(format: "$%.2f", soupsOrSalads[indexPath.item].price)
            cell.itemPrice?.text = formattedPrice
            break
        case 3:
            //Entrees
            cell.itemImage?.sd_setImage(with: entrees[indexPath.item].image)
            cell.itemName?.text = entrees[indexPath.item].name
            let formattedPrice = String(format: "$%.2f", entrees[indexPath.item].price)
            cell.itemPrice?.text = formattedPrice
            break
        case 4:
            //Kid's Entrees
            cell.itemImage?.sd_setImage(with: kidsEntrees[indexPath.item].image)
            cell.itemName?.text = kidsEntrees[indexPath.item].name
            let formattedPrice = String(format: "$%.2f", kidsEntrees[indexPath.item].price)
            cell.itemPrice?.text = formattedPrice
            break
        case 5:
            //Desserts
            cell.itemImage?.sd_setImage(with: desserts[indexPath.item].image)
            cell.itemName?.text = desserts[indexPath.item].name
            let formattedPrice = String(format: "$%.2f", desserts[indexPath.item].price)
            cell.itemPrice?.text = formattedPrice
            break
        default:
            return cell
        }
        
        // Sets text wrapping for better visuals
        // https://stackoverflow.com/questions/3931838/how-to-write-multiple-lines-in-a-label
        cell.itemName?.lineBreakMode = .byWordWrapping
        cell.itemName?.numberOfLines = 0
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // switch decides which item is clicked to send to the orderViewController
        var clickedIndex: MenuItem!
        switch rowIndex {
        case 0:
            clickedIndex = beverages[indexPath.item]
            break
        case 1:
            clickedIndex = appetizers[indexPath.item]
            break
        case 2:
            clickedIndex = soupsOrSalads[indexPath.item]
            break
        case 3:
            clickedIndex = entrees[indexPath.item]
            break
        case 4:
            clickedIndex = kidsEntrees[indexPath.item]
            break
        case 5:
            clickedIndex = desserts[indexPath.item]
            break
        default:
            clickedIndex = nil
        }
        
        // Sends correct item to the order table for payments
        self.cellDelegate!.didTapCell(clickedIndex)
        
    }

}
