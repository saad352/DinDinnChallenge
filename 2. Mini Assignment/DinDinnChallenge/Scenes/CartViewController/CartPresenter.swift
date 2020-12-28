//
//  CartPresenter.swift
//  DinDinnChallenge
//
//  Created by MBP on 26/12/2020.
//  Copyright © 2020 Saad Abdullah. All rights reserved.
//

import Foundation

protocol CartView: class {
    func didFetchCartItems()
    func didFetchCartError(title: String, message: String)
}

protocol CartCellView {
    func configure(with viewModel: CartCellViewModel, forIndex: Int, itemDeleteAction: ((_ index: Int) -> ())?)
}

protocol CartPresenter {
    var cartItems: [CartItem] { get }
    
    func fetchCartItems()
    func configure(cell: CartCellView, forIndex: IndexPath)
}

class CartPresenterImpl: CartPresenter {
    var cartItems = [CartItem]()
    weak var view: CartView!
    
    init(view: CartView) {
        self.view = view
    }
    
    func fetchCartItems() {
        self.cartItems = Cart.shared.getItems()
        self.view?.didFetchCartItems()
    }
    
    func configure(cell: CartCellView, forIndex: IndexPath) {
        let vm = CartCellViewModel(item: cartItems[forIndex.row])
        cell.configure(with: vm, forIndex: forIndex.row, itemDeleteAction: { [weak self] index in
            self?.deleteItem(atIndex: index)
        })
    }
    
    private func deleteItem(atIndex: Int) {
        print(atIndex)
        Cart.shared.deleteItem(at: atIndex)
        self.fetchCartItems()
    }
}
