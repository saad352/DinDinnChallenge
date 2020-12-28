//
//  CartConfigurator.swift
//  DinDinnChallenge
//
//  Created by MBP on 26/12/2020.
//  Copyright © 2020 Saad Abdullah. All rights reserved.
//

import Foundation

protocol CartConfigurator {
    func configure(cartViewController: CartViewController)
}

class CartConfiguratorImpl: CartConfigurator {
    
    init() {}
    
    func configure(cartViewController: CartViewController) {
        
        let presenter = CartPresenterImpl(view: cartViewController)
        cartViewController.presenter = presenter
    }
}
