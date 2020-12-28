//
//  DisplayFood.swift
//  DinDinnChallenge
//
//  Created by MBP on 23/12/2020.
//  Copyright © 2020 Saad Abdullah. All rights reserved.
//

import Foundation

protocol DisplayFoodUsecase {
    func fetchFoodList(callback: @escaping (Result<[Food],Error>) -> Void)
}

class DisplayFoodUsecaseImpl: DisplayFoodUsecase {
    
    private let foodGateway: FoodListGateway
    init(gateway: FoodListGateway) {
        self.foodGateway = gateway
    }
    
    func fetchFoodList(callback: @escaping (Result<[Food],Error>) -> Void) {
        foodGateway.fetchFoodList { result in
            DispatchQueue.main.async {
                callback(result)
            }
        }
    }
    
}
