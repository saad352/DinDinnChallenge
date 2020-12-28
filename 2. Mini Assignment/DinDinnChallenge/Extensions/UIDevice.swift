//
//  UIDevice.swift
//  DinDinnChallenge
//
//  Created by MBP on 24/12/2020.
//  Copyright © 2020 Saad Abdullah. All rights reserved.
//

import UIKit

extension UIDevice {
    class var isPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }

    class var isPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
}
