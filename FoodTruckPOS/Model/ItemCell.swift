//
//  Item.swift
//  FoodTruckPOS
//
//  Created by Derik Gagnon on 12/3/18.
//  Copyright © 2018 Derik Gagnon. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet var collectionView: UICollectionView!
    
    let itemsArray = [
        Item(name: "Burger", price: 8.99, image: "burger", type: "Entree"),
        Item(name: "Hotdog", price: 5.99, image: "hotdog", type: "Entree"),
        Item(name: "Bean Burrito", price: 8.99, image: "bean_burrito", type: "Entree")
    ]
    
//    
//    var cell: Item? {
//        didSet {
//            guard let cell = cell else {
//                return
//            }
//            self.name?.text = cell.name
//            self.price?.text = cell.price.description
//            self.cellImage?.image = UIImage(named: cell.image)
//        }
//    } 
//    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


extension ItemCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CustomCollectionCell
        
        cell.collectionImageView.image = UIImage(named: itemsArray[indexPath.row].image)
        cell.collectionName.text = itemsArray[indexPath.row].name
        cell.collectionPrice.text = String(itemsArray[indexPath.row].price)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let clickedIndex = itemsArray[indexPath.row]
        
        print(clickedIndex)
        
        
    }
    

}