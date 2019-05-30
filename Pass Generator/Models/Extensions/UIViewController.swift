//
//  UIViewController.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 24.05.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    /**
     Sets up and shows an Alert
     
     - Parameters:
        - title: The title of the alert
        - message: The message of the alert
        - style: The style, default is alert
     
     - Returns: Void
     */
    func showAlertWith(title: String, message: String, style: UIAlertController.Style = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
}
