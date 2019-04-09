//
//  CustomCollectionCell.swift
//  FoodTruckPOS
//
//  Created by Derik Gagnon on 2/19/19.
//  Copyright © 2019 Derik Gagnon. All rights reserved.
//

import UIKit
import Foundation

// Outlets for the collection cells
class MenuCollectionCell: UICollectionViewCell {
    @IBOutlet var itemImage: UIImageView?
    @IBOutlet var itemName: UILabel?
    @IBOutlet var itemPrice: UILabel?
}
