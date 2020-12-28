//
//  Cart.swift
//  DinDinnChallenge
//
//  Created by MBP on 26/12/2020.
//  Copyright © 2020 Saad Abdullah. All rights reserved.
//

import Foundation

class CartItem {
    var food: Food!
    var quantity: Int = 0
    
    init(food: Food, quantity: Int = 0) {
        self.food = food
        self.quantity = quantity
    }
}

class Cart {
    static let shared = Cart()
    private init () { }
    
    private var items = [CartItem]()
    
    func getItems() -> [CartItem] {
        return items
    }
    
    func addItem(item: CartItem) {
        items.append(item)
    }
    
    func deleteItem(at index: Int) {
        items.remove(at: index)
    }
}
