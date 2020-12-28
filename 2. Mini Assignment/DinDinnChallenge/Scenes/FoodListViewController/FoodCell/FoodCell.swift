//
//  FoodCell.swift
//  DinDinnChallenge
//
//  Created by MBP on 23/12/2020.
//  Copyright © 2020 Saad Abdullah. All rights reserved.
//

import UIKit

class FoodCell: UICollectionViewCell {
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var ingredientsDetailLabel: UILabel!
    @IBOutlet weak var weightDetailLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    
    var viewModel: FoodCellViewModel!
    var itemSelectedAction: ((_ index: Int) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        shadowView.giveShadow(withOpacityDefaultZeroEight: 0.22, withRadiusDefaultTwo: 2.0)
        shadowView.layer.cornerRadius = 15.0
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 15.0
        
        self.addToCartButton.addTarget(self, action: #selector(itemAddedToCart(sender:)), for: .touchUpInside)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    @objc func itemAddedToCart(sender: UIButton) {
        
        self.animateButton(sender: sender)
        print("Add this Item to Cart -> \(viewModel.name) \(viewModel.type)")
        itemSelectedAction?(sender.tag)
    }
    
    func animateButton(sender: UIButton) {
        UIView.animate(withDuration: 0.9, delay: 0, options: .curveEaseIn, animations: {
            sender.backgroundColor = Constants.Color.green
            sender.setTitle("added +1", for: .normal)
        }, completion: { [weak self] _ in
            print("Animation Done")
            
            UIView.animate(withDuration: 0.2, delay: 0, animations: { [weak self] in
                self?.addToCartButton.setTitle(self?.viewModel.price, for: .normal)
                self?.addToCartButton.backgroundColor = .black
            })
        })
    }
    
}

extension FoodCell: FoodCellView {
    func configure(with viewModel: FoodCellViewModel, forIndex: Int, itemSelectedAction: ((Int) -> ())?) {
        self.viewModel = viewModel
        addToCartButton.tag = forIndex
        self.itemSelectedAction = itemSelectedAction
        
        self.nameLabel.text = viewModel.name
        self.imageView.image = UIImage(named: viewModel.image)
        self.ingredientsDetailLabel.text = viewModel.details
        self.weightDetailLabel.text = viewModel.weightDetails
        
        self.addToCartButton.setTitle(viewModel.price, for: .normal)
        self.addToCartButton.backgroundColor = .black

        
    }
    
}
