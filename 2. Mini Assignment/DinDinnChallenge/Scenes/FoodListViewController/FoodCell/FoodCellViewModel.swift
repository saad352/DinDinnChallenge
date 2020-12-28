//
//  FoodCellViewModel.swift
//  DinDinnChallenge
//
//  Created by MBP on 24/12/2020.
//  Copyright © 2020 Saad Abdullah. All rights reserved.
//

import Foundation

class FoodCellViewModel {
    let name: String
    let price: String
    let details: String
    let image: String
    
    let type: FoodType
    let taste: FoodTaste
    let weightDetails: String
    
    init(food: Food) {
        name = food.name
        price = "\(Int(food.price)) usd"
        details = food.details
        image = food.image
        
        type = food.type
        taste = food.taste
        if food.type == .pizza {
            weightDetails = "\(food.weight) grams, \(food.size) cm"
        } else if food.type == .sushi {
            weightDetails = "\(food.weight) grams, \(food.size) pieces"
        } else {
            weightDetails = "\(food.weight) grams"
        }
    }
}
