//
//  RegistrationViewController.swift
//  CoffeeIOS
//
//  Created by Vladyslav Horbenko on 1/9/19.
//  Copyright © 2019 Vladyslav Horbenko. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func tappedHideKeyBoard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @IBAction func tappedSignUp(_ sender: UIButton) {
        guard let access = NetworkServices(url: "http://31fdcf07.ngrok.io/iossignupuser/"),
            let name = self.nameTextField.text,
            let password = self.passwordTextField.text,
            let repeatPassword = self.repeatPasswordTextField.text,
            let email = self.emailTextField.text
            else {
                ErrorAlert.printMessage(message: "Заповніть всі поля для вводу", viewController: self)
                return
        }
        if password == repeatPassword{
            let data = "name=\(name)&password=\(password)&userEmail=\(email)"
            access.login(data:data) { (json, error) in
                if error != nil {
                    ErrorAlert.printMessage(message: error?.localizedDescription ?? "Something wrong", viewController: self)
                }
                if json != nil {
                    guard let data = json else {return}
                    print(data)
                    if data["resStatus"] as! String == "userCreated" {
                        self.performSegue(withIdentifier: "returnToLoginSegue", sender: nil)
                    } else {
                        ErrorAlert.printMessage(message: "Перевірте коректність даних", viewController: self)
                    }
                }
            }
        }
    }
    
    @IBAction func tuppedOnOut(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
