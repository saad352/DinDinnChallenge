//
//  CartButton.swift
//  DinDinnChallenge
//
//  Created by MBP on 25/12/2020.
//  Copyright © 2020 Saad Abdullah. All rights reserved.
//

import UIKit

class CartButton: UIView {
    
    var cartButtonAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }

    func commonInit() {
        setView(viewName: self.className)
    }
    
    @IBAction func cartButtonAction(sender: UIButton) {
        cartButtonAction?()
    }
}
