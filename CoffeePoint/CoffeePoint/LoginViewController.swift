//
//  ViewController.swift
//  CoffeePoint
//
//  Created by Vladyslav Horbenko on 12/4/18.
//  Copyright © 2018 Vladyslav Horbenko. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func pressOnButtonRegistration(_ sender: UIButton) {
        self.performSegue(withIdentifier: "registrationSegue", sender: nil)
    }
}

