//
//  CartCellViewModel.swift
//  DinDinnChallenge
//
//  Created by MBP on 26/12/2020.
//  Copyright © 2020 Saad Abdullah. All rights reserved.
//

import Foundation

class CartCellViewModel {
    let name: String
    let price: String
    let details: String
    let image: String
    
    var quantity = 0
    
    init(item: CartItem) {
        name = item.food.name
        price = "\(Int(item.food.price)) usd"
        details = item.food.details
        image = item.food.image
    }
}
