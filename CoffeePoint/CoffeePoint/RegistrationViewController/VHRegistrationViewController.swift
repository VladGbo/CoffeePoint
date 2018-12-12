//
//  VHRegistrationViewController.swift
//  CoffeePoint
//
//  Created by Vladyslav Horbenko on 12/10/18.
//  Copyright © 2018 Vladyslav Horbenko. All rights reserved.
//

import UIKit
import Firebase


class VHRegistrationViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var passRepeatTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    @IBAction func pressOnSignUpButton(_ sender: UIButton) {
        guard let userName = self.userNameTextField.text else {
            VHInfoSystemAlert.alertSystemInfo(title: "ERROR",
                                            message: "Incorrect user name",
                                     viewController: self)
            return
        }
        guard let email = self.emailTextField.text else {
            VHInfoSystemAlert.alertSystemInfo(title: "ERROR",
                                            message: "Incorrect email",
                                     viewController: self)
            return
        }
        guard let pass = self.passTextField.text else {
            VHInfoSystemAlert.alertSystemInfo(title: "ERROR",
                                            message: "Insert password",
                                     viewController: self)
            return
        }
        guard let passRepeat = self.passRepeatTextField.text else {
            VHInfoSystemAlert.alertSystemInfo(title: "ERROR",
                                            message: "Repeat password",
                                     viewController: self)
            return
        }
        if pass == passRepeat, !userName.isEmpty{
            Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
                guard error == nil else {
                    VHInfoSystemAlert.alertSystemInfo(title: "ERROR",
                                                    message: error?.localizedDescription ?? "",
                                             viewController: self)
                    return
                }
                guard let us = user else { return }
                let changeRequest = us.user.createProfileChangeRequest()
                changeRequest.displayName = userName
                changeRequest.commitChanges(completion: { (error) in
                    guard error == nil else {
                        VHInfoSystemAlert.alertSystemInfo(title: "ERROR",
                                                        message: error?.localizedDescription ?? "",
                                                 viewController: self)
                        return
                    }
                })
                    self.performSegue(withIdentifier: "segueRegistrationToUser", sender: nil)
            }
            
        } else {
            VHInfoSystemAlert.alertSystemInfo(title: "ERROR",
                                            message: "Passwords not equal each other, or didn't insert user name",
                                     viewController: self)
        }

    }

    @IBAction func pressOnCancelButton(_ sender: UIButton) {
//        self.performSegue(withIdentifier: "segueRegistrationToLogin", sender: nil)
        dismiss(animated: true, completion: nil)
    }
}
