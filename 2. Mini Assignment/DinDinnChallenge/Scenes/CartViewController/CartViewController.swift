//
//  CartViewController.swift
//  DinDinnChallenge
//
//  Created by MBP on 25/12/2020.
//  Copyright © 2020 Saad Abdullah. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var configurator: CartConfigurator!
    var presenter: CartPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
        
        configurator.configure(cartViewController: self)
        presenter.fetchCartItems()
    }
    
    func setUpTableView() {
        tableView.dataSource = self
        tableView.register(UINib(nibName: CartCell.className, bundle: nil), forCellReuseIdentifier: CartCell.className)
        tableView.separatorStyle = .none
    }
    
    static func returnController() -> CartViewController {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        return sb.instantiateViewController(withIdentifier: CartViewController.className) as! CartViewController
    }
}

extension CartViewController: CartView {
    func didFetchCartItems() {
        self.tableView.reloadData()
    }
    
    func didFetchCartError(title: String, message: String) {
        
    }
}

extension CartViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartCell.className) as! CartCell
        presenter.configure(cell: cell, forIndex: indexPath)
        return cell
    }
}
