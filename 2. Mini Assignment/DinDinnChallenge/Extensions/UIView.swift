//
//  ShadowedView.swift
//  DinDinnChallenge
//
//  Created by MBP on 24/12/2020.
//  Copyright © 2020 Saad Abdullah. All rights reserved.
//

import UIKit

extension UIView {
    @IBInspectable var borderColor: UIColor? {
        get { return layer.borderColor.map(UIColor.init) }
        set { layer.borderColor = newValue?.cgColor }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
}


extension UIView {
    
    func giveSimpleShadow() {
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = .init(width: 0.0, height: 1.0)
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 2.0
    }
    
    func giveShadow(withOpacityDefaultZeroEight opacity: Float = 0.8, withRadiusDefaultTwo radius: CGFloat = 2.0) {
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = .init(width: 0.0, height: 3.0)
        
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
    }
    
    func giveSquareShadowOnAllSides() {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowRadius = 3.0
        self.layer.shadowOffset = CGSize(width: 1.0,height: 1.0)
        self.layer.shadowOpacity = 1.0
    }
    
    func giveEzyEduShadow() {
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = .init(width: 0.0, height: 0.0)
        layer.shadowOpacity = 0.32
        layer.shadowRadius = 4.8
    }
    
    static func returnEmptyView() -> UIView {
        return UIView(frame: .zero)
    }
    
    func addEndEditingTapGesture() {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(self.handleDismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleDismissKeyboard() {
        UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.endEditing(true)
    }
    
    @discardableResult
    func setView(viewName: String) -> UIView? {
        if let view = Bundle.main.loadNibNamed(viewName, owner: self, options: nil)?[0] as? UIView {
            addSubview(view)
            
            view.translatesAutoresizingMaskIntoConstraints = false
            addConstraint(NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0))
            addConstraint(NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0))
            addConstraint(NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0))
            addConstraint(NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0))
            return view
        }
        return nil
    }
}

