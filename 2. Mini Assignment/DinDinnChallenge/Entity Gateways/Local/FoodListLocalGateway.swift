//
//  FoodListLocalGateway.swift
//  DinDinnChallenge
//
//  Created by MBP on 23/12/2020.
//  Copyright © 2020 Saad Abdullah. All rights reserved.
//

import Foundation

enum FoodCategoryJSONList: String {
    case pizza = "PizzaList"
    case sushi = "SushiList"
}

class FoodListLocalGateway: FoodListGateway {
    
    private let foodCategory: FoodCategoryJSONList
    
    init(for category: FoodCategoryJSONList) {
        self.foodCategory = category
    }
    
    func fetchFoodList(callback: @escaping (Result<[Food],Error>) -> Void) {
        
        let localFile = foodCategory.rawValue
        guard let path = Bundle.main.path(forResource: localFile, ofType: "json") else {
            callback(.failure(FetchFoodError.pathNotFound))
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let food = try parse(json: data)
            callback(.success(food))
        } catch (let error) {
            print(error)
            callback(.failure(error))
        }
    }
    
    private func parse(json: Data) throws -> [Food] {
        let jsonDecoder = JSONDecoder()
        do {
            let food = try jsonDecoder.decode([Food].self, from: json)
            return food
        } catch let err {
            print(err)
            throw FetchFoodError.parseFailed
        }
    }
    
}


extension FoodListLocalGateway {
    enum FetchFoodError: Error, LocalizedError {
        case parseFailed
        case pathNotFound
        var errorDescription: String? {
            switch self {
            case .parseFailed:
                return NSLocalizedString("Parse Error for fetchFood API", comment: "Parsing Error")
            case .pathNotFound:
                return NSLocalizedString("Path Error for fetchFood JSON file", comment: "Path Not found")
            }
        }
    }
}
