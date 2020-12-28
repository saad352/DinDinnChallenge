//
//  FoodListRouter.swift
//  DinDinnChallenge
//
//  Created by MBP on 23/12/2020.
//  Copyright © 2020 Saad Abdullah. All rights reserved.
//

import Foundation
import UIKit

protocol FoodListRouter {
    func checkoutToCart()
}

class FoodListRouterImpl: FoodListRouter {
    
    private let viewController: FoodListViewController
    
    init(viewController: FoodListViewController) {
        self.viewController = viewController
    }
    func checkoutToCart() {
        let cartViewController = CartViewController.returnController()
        let configurator = CartConfiguratorImpl()
        cartViewController.configurator = configurator
        
        viewController.present(cartViewController, animated: true, completion: nil)
    }
}
