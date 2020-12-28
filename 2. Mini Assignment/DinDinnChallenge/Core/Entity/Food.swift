//
//  Food.swift
//  DinDinnChallenge
//
//  Created by MBP on 23/12/2020.
//  Copyright © 2020 Saad Abdullah. All rights reserved.
//

import Foundation

enum FoodType: String, Decodable {
    case pizza
    case sushi
    case drinks
}

enum FoodTaste: String, Decodable {
    case spicy
    case vegan
    case sweet
}

struct Food: Decodable, Hashable {
    var name: String
    var price: Double
    var details: String
    var image: String
    
    var type: FoodType
    var taste: FoodTaste
    var weight: Int
    var size: Int
}

