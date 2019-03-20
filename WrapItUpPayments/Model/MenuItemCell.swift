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
    
    let categories = ["Beverages", "Appetizers", "Soups Or Salads", "Entrees", "Kid's Entrees", "Desserts"]
    
    let beverages = [
        MenuItem(name: "Lemonade", price: 2.49, image: "lemonade", type: "Beverages"),
        MenuItem(name: "Pepsi", price: 1.99, image: "soda", type: "Beverages"),
        MenuItem(name: "Mountain Dew", price: 1.99, image: "soda", type: "Beverages"),
        MenuItem(name: "Iced Tea", price: 2.49, image: "icedtea", type: "Beverages"),
        MenuItem(name: "Water", price: 0.99, image: "water", type: "Beverages")
    ]
    
    let appetizers = [
        MenuItem(name: "Breaksticks with Alfredo Sauce", price: 5.99, image: "breadsticks", type: "Appetizers"),
        MenuItem(name: "White Queso Dip & Chips", price: 4.99, image: "whitequeso", type: "Appetizers"),
        MenuItem(name: "Chicken Quesadilla", price: 8.99, image: "chickenquesadilla", type: "Appetizers"),
        MenuItem(name: "Spinach & Artichoke Dip", price: 7.99, image: "spinachartichokedip", type: "Appetizers"),
        MenuItem(name: "Buffalo Boneless Wings", price: 10.99, image: "bonelesswings", type: "Appetizers")
    ]
    
    let soupsOrSalads = [
        MenuItem(name: "Southwestern Chicken Salad", price: 10.29, image: "southwesternsalad", type: "Soups Or Salads"),
        MenuItem(name: "Thai Shrimp Salad", price: 12.29, image: "thaisalad", type: "Soups Or Salads"),
        MenuItem(name: "Chicken Ceaser Salad", price: 10.79, image: "ceasersalad", type: "Soups Or Salads"),
        MenuItem(name: "Chicken Noodle Soup", price: 5.69, image: "chickensoup", type: "Soups Or Salads")
    ]
    
    let entrees = [
        MenuItem(name: "Riblet Basket", price: 10.29, image: "riblet", type: "Entrees"),
        MenuItem(name: "Bourbon Street Steak", price: 15.99, image: "bourbonsteak", type: "Entrees"),
        MenuItem(name: "Chicken Tenders Platter", price: 11.79, image: "chickenplatter", type: "Entrees"),
        MenuItem(name: "Fiesta Lime Chicken", price: 12.29, image: "fiestalimechicken", type: "Entrees"),
        MenuItem(name: "Cedar Grilled Lemon Chicken", price: 12.49, image: "grilledlemonchicken", type: "Entrees"),
        MenuItem(name: "Shrimp Wonton Stir Fry", price: 12.49, image: "shrimpwonton", type: "Entrees"),
        MenuItem(name: "Double Crunch Shrimp", price: 14.29, image: "doublecrunchshrimp", type: "Entrees"),
        MenuItem(name: "Creamy Penne Pasta With Sliced Prime Rib", price: 12.79, image: "creamypenneslicedrib", type: "Entrees"),
        MenuItem(name: "Classic Broccoli Chicken Alfredo", price: 12.79, image: "broccolichickenalfredo", type: "Entrees"),
        MenuItem(name: "Classic Chicken Parmesan", price: 13.49, image: "chickenparmesan", type: "Entrees"),
        MenuItem(name: "Classic Cheeseburger", price: 10.29, image: "burger", type: "Entrees")
    ]
    
    let kidsEntrees = [
        MenuItem(name: "Kid's Cheesy Pizza", price: 6.49, image: "kidpizza", type: "Kid's Entrees"),
        MenuItem(name: "Kid's Chicken Tenders", price: 6.49, image: "kidchicken", type: "Kid's Entrees"),
        MenuItem(name: "Kid's Corn Dog", price: 6.49, image: "kidcorndog", type: "Kid's Entrees")
    ]
    
    let desserts = [
        MenuItem(name: "Hot Fudge Sundae", price: 2.69, image: "hotfudgesundae", type: "Desserts"),
        MenuItem(name: "Blue Ribbon Brownie", price: 5.69, image: "blueribbonbrownie", type: "Desserts")
    ]
    
    weak var cellDelegate: MenuRowDelegate!
    var rowIndex = 0
    @IBOutlet var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        

    }
    
    override func prepareForReuse() {
        collectionView.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
        
        switch rowIndex {
        case 0:
            //Beverages
            cell.itemImage?.image = UIImage(named: beverages[indexPath.item].image)
            cell.itemName?.text = beverages[indexPath.item].name
            let formattedPrice = String(format: "$%.2f", beverages[indexPath.item].price)
            cell.itemPrice?.text = formattedPrice
            break
        case 1:
            //Appetizers
            cell.itemImage?.image = UIImage(named: appetizers[indexPath.item].image)
            cell.itemName?.text = appetizers[indexPath.item].name
            let formattedPrice = String(format: "$%.2f", appetizers[indexPath.item].price)
            cell.itemPrice?.text = formattedPrice
            break
        case 2:
            //Soups or Salads
            cell.itemImage?.image = UIImage(named: soupsOrSalads[indexPath.item].image)
            cell.itemName?.text = soupsOrSalads[indexPath.item].name
            let formattedPrice = String(format: "$%.2f", soupsOrSalads[indexPath.item].price)
            cell.itemPrice?.text = formattedPrice
            break
        case 3:
            //Entrees
            cell.itemImage?.image = UIImage(named: entrees[indexPath.item].image)
            cell.itemName?.text = entrees[indexPath.item].name
            let formattedPrice = String(format: "$%.2f", entrees[indexPath.item].price)
            cell.itemPrice?.text = formattedPrice
            break
        case 4:
            //Kid's Entrees
            cell.itemImage?.image = UIImage(named: kidsEntrees[indexPath.item].image)
            cell.itemName?.text = kidsEntrees[indexPath.item].name
            let formattedPrice = String(format: "$%.2f", kidsEntrees[indexPath.item].price)
            cell.itemPrice?.text = formattedPrice
            break
        case 5:
            //Desserts
            cell.itemImage?.image = UIImage(named: desserts[indexPath.item].image)
            cell.itemName?.text = desserts[indexPath.item].name
            let formattedPrice = String(format: "$%.2f", desserts[indexPath.item].price)
            cell.itemPrice?.text = formattedPrice
            break
        default:
            return cell
        }
        
        // https://stackoverflow.com/questions/3931838/how-to-write-multiple-lines-in-a-label
        cell.itemName?.lineBreakMode = .byWordWrapping
        cell.itemName?.numberOfLines = 0
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
        self.cellDelegate!.didTapCell(clickedIndex)
        //print(clickedIndex.name)
        
        
    }

}
