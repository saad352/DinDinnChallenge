//
//  FoodListGateway.swift
//  DinDinnChallenge
//
//  Created by MBP on 23/12/2020.
//  Copyright © 2020 Saad Abdullah. All rights reserved.
//

import Foundation

protocol FoodListGateway {
    func fetchFoodList(callback: @escaping (Result<[Food],Error>) -> Void)
}

