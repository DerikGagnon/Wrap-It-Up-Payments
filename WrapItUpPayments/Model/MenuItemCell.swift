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
    
    let itemsArray = [
        MenuItem(name: "Bacon Cheddar Grilled Chicken Sandwich", price: 8.99, image: "burger", type: "Entrees"),
        MenuItem(name: "Breadsticks with Alfredo Sauce", price: 5.99, image: "hotdog", type: "Entrees"),
        MenuItem(name: "Bean Burrito", price: 8.99, image: "bean_burrito", type: "Entrees")
    ]
    
    weak var cellDelegate: MenuRowDelegate!
    @IBOutlet var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! MenuCollectionCell
        
        cell.itemImage?.image = UIImage(named: itemsArray[indexPath.item].image)
        cell.itemName?.text = itemsArray[indexPath.item].name
        let formattedPrice = String(format: "$%.2f", itemsArray[indexPath.item].price)
        cell.itemPrice?.text = formattedPrice
        
        // https://stackoverflow.com/questions/3931838/how-to-write-multiple-lines-in-a-label
        cell.itemName?.lineBreakMode = .byWordWrapping
        cell.itemName?.numberOfLines = 0
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let clickedIndex = itemsArray[indexPath.item]
        self.cellDelegate!.didTapCell(clickedIndex)
        //print(clickedIndex.name)
        
        
    }

}
