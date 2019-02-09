//
//  ErrorAlert.swift
//  CoffeeIOS
//
//  Created by Vladyslav Horbenko on 1/5/19.
//  Copyright © 2019 Vladyslav Horbenko. All rights reserved.
//

import Foundation
import UIKit

class ErrorAlert {
    
    static func printMessage(message:String, viewController: UIViewController) {
        let alert = UIAlertController(title: "INFO", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(alertAction)
        viewController.present(alert, animated: true, completion: nil)
    }
}
