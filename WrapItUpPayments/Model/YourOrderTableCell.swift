//
//  YourOrderTableCell.swift
//  FoodTruckPOS
//
//  Created by Derik Gagnon on 2/5/19.
//  Copyright © 2019 Derik Gagnon. All rights reserved.
//

import UIKit

class YourOrderTableCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Word wrapping for the table view controller
        // https://stackoverflow.com/questions/3931838/how-to-write-multiple-lines-in-a-label
        nameLabel.lineBreakMode = .byWordWrapping
        nameLabel.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
