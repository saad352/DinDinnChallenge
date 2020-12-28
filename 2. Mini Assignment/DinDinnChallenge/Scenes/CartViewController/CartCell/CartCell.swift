//
//  CartCell.swift
//  DinDinnChallenge
//
//  Created by MBP on 26/12/2020.
//  Copyright © 2020 Saad Abdullah. All rights reserved.
//

import UIKit

class CartCell: UITableViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var index: Int!
    var cartItemDelecteAction: ((Int) -> Void)?
    
    var viewModel: CartCellViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func removeItem(sender: UIButton) {
        cartItemDelecteAction?(index)
    }
}

extension CartCell: CartCellView {
    func configure(with viewModel: CartCellViewModel, forIndex: Int, itemDeleteAction: ((Int) -> ())?) {
        self.viewModel = viewModel
        self.index = forIndex
        self.cartItemDelecteAction = itemDeleteAction
        
        self.itemImage.image = UIImage(named: viewModel.image)
        self.nameLabel.text = viewModel.name
        self.priceLabel.text = viewModel.price
    }
    
}
