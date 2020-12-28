//
//  AlertController.swift
//  DinDinnChallenge
//
//  Created by MBP on 24/12/2020.
//  Copyright © 2020 Saad Abdullah. All rights reserved.
//

import Foundation
import UIKit

// Returns ready made AlertControllers
class AlertController {
    public static func infoAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        return alert
    }
}
