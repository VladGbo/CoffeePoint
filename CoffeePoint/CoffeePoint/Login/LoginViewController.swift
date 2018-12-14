//
//  ViewController.swift
//  CoffeePoint
//
//  Created by Vladyslav Horbenko on 12/4/18.
//  Copyright © 2018 Vladyslav Horbenko. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet var itemsForlogIn: [UITextField]!
    
    private var infoError: String = "" {
        didSet {
            VHInfoSystemAlert.errorInfo(title: "ERROR", message: "Something wrong with \(infoError)", viewController: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func tappedHideKey(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    @IBAction func pressOnButtonRegistration(_ sender: UIButton) {
        self.performSegue(withIdentifier: "registrationSegue", sender: nil)
    }
    
    @IBAction func tappedLoginButton(_ sender: UIButton) {
        guard let email = self.itemsForlogIn[0].text,
            !email.isEmpty else {
                self.infoError = "email"
                return
        }
        guard let password = self.itemsForlogIn[1].text,
            !password.isEmpty else {
                self.infoError = "password"
                return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                self.infoError = error?.localizedDescription ?? "autorization was dismissing"
            } else {
                self.performSegue(withIdentifier: "segueLoginToUser", sender: nil)
            }
        }

    }
}

