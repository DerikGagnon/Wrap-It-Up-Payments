//
//  Item.swift
//  FoodTruckPOS
//
//  Created by Derik Gagnon on 12/3/18.
//  Copyright © 2018 Derik Gagnon. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    //@IBOutlet weak var desc: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    
    var cell: Item? {
        didSet {
            guard let cell = cell else {
                return
            }
            self.name?.text = cell.name
            //self.desc?.text = cell.desc
            self.cellImage?.image = UIImage(named: cell.image)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
