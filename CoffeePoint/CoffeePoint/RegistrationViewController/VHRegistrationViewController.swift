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
    
    private var errorText: String = ""{
        didSet {
            VHInfoSystemAlert.errorInfo(title: "ERROR", message: errorText, viewController: self)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func hideKey(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func pressOnSignUpButton(_ sender: UIButton) {
        guard let userName = self.userNameTextField.text else {
            self.errorText = "Incorrect user name"
            return
        }
        guard let email = self.emailTextField.text else {
            self.errorText = "Incorrect email"
            return
        }
        guard let pass = self.passTextField.text else {
            self.errorText = "Insert password"
            return
        }
        guard let passRepeat = self.passRepeatTextField.text else {
            self.errorText = "Repeat password"
            return
        }
        if pass == passRepeat, !userName.isEmpty{
            Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
                guard error == nil else {
                    self.errorText = error?.localizedDescription ?? ""
                    return
                }
                guard let us = user else { return }
                let changeRequest = us.user.createProfileChangeRequest()
                changeRequest.displayName = userName
                changeRequest.commitChanges(completion: { (error) in
                    guard error == nil else {
                        self.errorText = error?.localizedDescription ?? ""
                        return
                    }
                })
                
                self.dismiss(animated: true, completion: nil)
            }
            
        } else {
            self.errorText = "Passwords not equal each other, or didn't insert user name"
        }
    }
    
    @IBAction func pressOnCancelButton(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
}
