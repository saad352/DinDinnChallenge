//
//  DisplayFoodUsecaseTest.swift
//  DinDinnChallengeTests
//
//  Created by MBP on 28/12/2020.
//  Copyright © 2020 Saad Abdullah. All rights reserved.
//

import XCTest
@testable import DinDinn

class DisplayFoodUsecaseTest: XCTestCase {
    
    var foodGateway: FoodListLocalGateway!
    var displayFood: DisplayFoodUsecase!

    override func setUpWithError() throws {
        foodGateway = FoodListLocalGateway(for: .pizza)
        displayFood = DisplayFoodUsecaseImpl(gateway: foodGateway)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDisplayFoodSuccess() throws {
        
        let expectation = XCTestExpectation(description: "Will fetch food list successfully")
        
        displayFood.fetchFoodList { result in
            switch result {
            case .success(let foodList):
                print(foodList)
                XCTAssertNotNil(foodList)
                expectation.fulfill()
            case .failure(let error):
                print(error)
                XCTAssertNil(error)
            }
        }
    }
    
    func testFoodParse() throws {
        
        let expectation = XCTestExpectation(description: "Will fetch food list successfully and make list of Food objects")
        
        displayFood.fetchFoodList { result in
            switch result {
            case .success(let foodList):
                print(foodList)
                XCTAssertNotNil(foodList)
                
                let food = foodList[0]
                XCTAssertEqual("Deluxe", food.name, "Name parsed correctly")
                
                expectation.fulfill()
            case .failure(let error):
                print(error)
                XCTAssertNil(error)
            }
        }
    }
}
