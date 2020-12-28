//
//  HeaderView.swift
//  DinDinnChallenge
//
//  Created by MBP on 24/12/2020.
//  Copyright © 2020 Saad Abdullah. All rights reserved.
//

import UIKit
import ImageSlideshow

class FoodHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var imageSlideShow: ImageSlideshow!
    @IBOutlet weak var imageSlideShowHeight: NSLayoutConstraint!
    @IBOutlet weak var stackView: UIStackView!
    
    var viewSetupDone = false
    var images = [String]()
    var titleArr = [String]() {
        didSet {
            viewSetupDone == false ? setupView() : ()
        }
    }
    
    static var reuseIdentifier: String {
        return String(describing: FoodHeaderView.className)
    }
    
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
        
        imageSlideShow.slideshowInterval = 2.5
        
        imageSlideShow.pageIndicatorPosition = .init(horizontal: PageIndicatorPosition.Horizontal.center, vertical: PageIndicatorPosition.Vertical.customBottom(padding: 0.0))
        imageSlideShow.pageIndicator?.view.tintColor = UIColor.lightGray
        imageSlideShow.contentScaleMode = .scaleAspectFill
    }
    
    func setupView() {
        viewSetupDone = true
        if images.count != 0 {
            let sourceArr = images.map { ImageSource(image: UIImage(named: $0)!) }
            imageSlideShow.setImageInputs(sourceArr)
        } else {
            imageSlideShowHeight.constant = 30
        }
        
        for (index, title) in titleArr.enumerated() {
            let color = index == 0 ? .label : UIColor.lightGray
            stackView.addArrangedSubview(createBigLabel(for: title, color: color))
        }
    }
    
    
    func createBigLabel(for title: String, color: UIColor = .gray) -> UILabel {
        let label = UILabel()
        
        let widthConstraint = label.widthAnchor.constraint(equalToConstant: 90)
        widthConstraint.priority = UILayoutPriority(rawValue: 800)
        widthConstraint.isActive = true
        label.textAlignment = .center
        
        label.textColor = color
        label.text = title
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        return label
    }
}
