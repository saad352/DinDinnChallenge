//
//  FoodListConfigurator.swift
//  DinDinnChallenge
//
//  Created by MBP on 23/12/2020.
//  Copyright © 2020 Saad Abdullah. All rights reserved.
//

import Foundation

protocol FoodListConfigurator {
    func configure(foodListViewController: FoodListViewController)
}

class FoodListConfiguratorImpl: FoodListConfigurator {
    
    let category: FoodCategoryJSONList
    init(foodCategory: FoodCategoryJSONList) {
        category = foodCategory
    }
    
    func configure(foodListViewController: FoodListViewController) {
        let usecase = DisplayFoodUsecaseImpl(gateway: FoodListLocalGateway(for: category))
        let router = FoodListRouterImpl(viewController: foodListViewController)
        let presenter = FoodListPresenterImpl(view: foodListViewController, usecase: usecase, router: router)
        foodListViewController.presenter = presenter
    }
}
