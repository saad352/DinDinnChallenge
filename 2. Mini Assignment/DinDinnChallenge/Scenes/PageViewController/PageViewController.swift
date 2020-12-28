//
//  ViewController.swift
//  DinDinnChallenge
//
//  Created by MBP on 23/12/2020.
//  Copyright © 2020 Saad Abdullah. All rights reserved.
//

import UIKit

protocol PagedController where Self: UIViewController {
    var pageName: String { get set }
    var pageIndex: Int { get set }
}

class PageViewController: UIViewController {
    
    var pages: [PagedController] = [PagedController]()
    
    private var pageController: UIPageViewController?
    private var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.makeTestViewControllers()
        self.setupPageController()
    }
    
    func setupPageController() {
        pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: .none)
        self.pageController?.dataSource = self
        self.pageController?.delegate = self
        
        self.addChild(self.pageController!)
        self.view.addSubview(self.pageController!.view)
  
        pageController?.view.translatesAutoresizingMaskIntoConstraints = false
        let margin = view.layoutMarginsGuide
        self.pageController?.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.pageController?.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        self.pageController?.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.pageController?.view.bottomAnchor.constraint(equalTo: margin.bottomAnchor).isActive = true
        
        self.pageController?.setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
        self.pageController?.didMove(toParent: self)
    }

    func makeTestViewControllers() {
        let pizzaVC = FoodListViewController.returnController()
        pizzaVC.configurator = FoodListConfiguratorImpl(foodCategory: .pizza)
        pizzaVC.pageName = "Pizza"
        pizzaVC.pageIndex = 0
        pizzaVC.images = ["cheese.jpg","veggie.jpg"]
        
        let sushiVC = FoodListViewController.returnController()
        sushiVC.configurator = FoodListConfiguratorImpl(foodCategory: .sushi)
        sushiVC.pageName = "Sushi"
        sushiVC.pageIndex = 1
        
        pizzaVC.pagesTitle = [pizzaVC.pageName, sushiVC.pageName, "Drinks"]
        sushiVC.pagesTitle = [sushiVC.pageName, "Drinks", pizzaVC.pageName]
        
        pages.append(pizzaVC)
        pages.append(sushiVC)
    }
}

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? PagedController else {
            return nil
        }
        
        currentIndex = currentVC.pageIndex
        let prevIndex = currentIndex - 1
        if prevIndex < 0 {
            return nil
        }
         
        return pages[prevIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? PagedController else {
            return nil
        }
        
        currentIndex = currentVC.pageIndex
        let nextIndex = currentIndex + 1
        if nextIndex >= 2 {
            return nil
        }
         
        return pages[nextIndex]
    }
}
