//
//  Item.swift
//  FoodTruckPOS
//
//  Created by Derik Gagnon on 12/3/18.
//  Copyright © 2018 Derik Gagnon. All rights reserved.
//

import Foundation
import Firebase

class MenuItem {
    // Item variables
    var name: String
    var desc: String
    var price: Float32
    var image: StorageReference
    var type: String
    var allergies: String
    
    // Initializer
    init(name: String, desc: String, price: Float32, image: StorageReference, type: String, allergies: String) {
        self.name = name
        self.desc = desc
        self.price = price
        self.image = image
        self.type = type
        self.allergies = allergies
    }
    
    // Default Initializer
    init() {
        self.name = ""
        self.desc = ""
        self.price = 0.00
        self.image = Storage.storage().reference()
        self.type = ""
        self.allergies = ""
    }
}
