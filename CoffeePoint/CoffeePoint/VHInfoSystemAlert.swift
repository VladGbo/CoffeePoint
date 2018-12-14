//
//  VHInfoSystemAlert.swift
//  CoffeePoint
//
//  Created by Vladyslav Horbenko on 12/10/18.
//  Copyright © 2018 Vladyslav Horbenko. All rights reserved.
//

import UIKit

class VHInfoSystemAlert: NSObject {

    static func errorInfo(title:String, message: String, viewController:UIViewController) {
        let alertController:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        viewController.present(alertController, animated: true, completion: nil)
    }
}
