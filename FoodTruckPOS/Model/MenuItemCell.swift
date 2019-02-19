//
//  Item.swift
//  FoodTruckPOS
//
//  Created by Derik Gagnon on 12/3/18.
//  Copyright © 2018 Derik Gagnon. All rights reserved.
//

import UIKit

class MenuItemCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var menuImageView: UIImageView?
    @IBOutlet var menuNameLabel: UILabel?
    @IBOutlet var menuPriceLabel: UILabel?
    
    let itemsArray = [
        MenuItem(name: "Burger", price: 8.99, image: "burger", type: "Entrees"),
        MenuItem(name: "Hotdog", price: 5.99, image: "hotdog", type: "Entrees"),
        MenuItem(name: "Bean Burrito", price: 8.99, image: "bean_burrito", type: "Entrees")
    ]
    
    weak var cellDelegate: MenuCollectionDelegate?

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
        
        cell.collectionImageView.image = UIImage(named: itemsArray[indexPath.row].image)
        cell.collectionName.text = itemsArray[indexPath.row].name
        cell.collectionPrice.text = String(itemsArray[indexPath.row].price)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let clickedIndex = itemsArray[indexPath.row]
        self.cellDelegate?.didTapCell(clickedIndex)
        print(clickedIndex.name)
        
        
    }

}

