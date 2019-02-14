//
//  Item.swift
//  FoodTruckPOS
//
//  Created by Derik Gagnon on 12/3/18.
//  Copyright © 2018 Derik Gagnon. All rights reserved.
//

import UIKit

class MenuItemCell: UITableViewCell {
    
    @IBOutlet var menuImageView: UIImageView?
    @IBOutlet var menuNameLabel: UILabel?
    @IBOutlet var menuPriceLabel: UILabel?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
