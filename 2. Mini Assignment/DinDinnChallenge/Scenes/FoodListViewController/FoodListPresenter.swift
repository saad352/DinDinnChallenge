//
//  FoodListPresenter.swift
//  DinDinnChallenge
//
//  Created by MBP on 23/12/2020.
//  Copyright © 2020 Saad Abdullah. All rights reserved.
//

import Foundation

protocol FoodListView: class {
    func didFetchFoodListSuccess()
    func didFetchFoodListError(title: String, message: String)
}

protocol FoodCellView {
    func configure(with viewModel: FoodCellViewModel, forIndex: Int, itemSelectedAction: ((_ index: Int) -> ())?)
}

protocol FoodListPresenter {
    var foodItems: [Food] { get }
    
    func checkoutToCart()
    func fetchFoodList()
    func configure(cell: FoodCellView, for index: IndexPath)
}

class FoodListPresenterImpl: FoodListPresenter {
    var foodItems = [Food]()
    var foodCellItemsData = [FoodCellViewModel]()
    
    weak var view: FoodListView?
    let usecase: DisplayFoodUsecase
    let router: FoodListRouter
    
    init(view: FoodListView, usecase: DisplayFoodUsecase, router: FoodListRouter) {
        self.view = view
        self.usecase = usecase
        self.router = router
    }
    
    func fetchFoodList() {
        self.usecase.fetchFoodList { [weak self] result in
            switch result {
            case .success(let foodList):
                self?.foodItems = foodList
                self?.foodCellItemsData = foodList.map { FoodCellViewModel(food: $0) }
                self?.view?.didFetchFoodListSuccess()
            case .failure(let error):
                self?.view?.didFetchFoodListError(title: "Alert" ,message: error.localizedDescription)
            }
        }
    }
    
    func configure(cell: FoodCellView, for index: IndexPath) {
        let viewModel = foodCellItemsData[index.row]
        cell.configure(with: viewModel, forIndex: index.row, itemSelectedAction: { [weak self] index in
            if let food = self?.foodItems[index] {
                self?.addFoodToCart(food: food)
            }
        })
    }
    
    func checkoutToCart() {
        router.checkoutToCart()
    }
    
    func addFoodToCart(food: Food) {
        let item = CartItem(food: food)
        Cart.shared.addItem(item: item)
    }
}
