//
//  ViewController.swift
//  CoffeePoint
//
//  Created by Vladyslav Horbenko on 12/4/18.
//  Copyright © 2018 Vladyslav Horbenko. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var itemsForlogIn: [UITextField]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func pressOnButtonRegistration(_ sender: UIButton) {


        self.performSegue(withIdentifier: "registrationSegue", sender: nil)
    }
    @IBAction func tappedLoginButton(_ sender: UIButton) {
        

        
        //        var login = LoginModel(userName: <#T##String#>, password: <#T##String#>)
    }
}

