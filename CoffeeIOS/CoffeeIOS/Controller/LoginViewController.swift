//
//  LoginViewController.swift
//  CoffeeIOS
//
//  Created by Vladyslav Horbenko on 1/3/19.
//  Copyright © 2019 Vladyslav Horbenko. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private var loginedUser: UserCoffee?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func tappedHideKeyBoard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func pressLoginButtton(_ sender: UIButton) {
        guard let access = NetworkServices(url: "http://31fdcf07.ngrok.io/iosuserlogin/"),
        let name = self.loginTextField.text,
        let password = self.passwordTextField.text
        else { return }
        let data = "username=\(name)&password=\(password)"
        access.login(data:data) { (json, error) in
            if error != nil {
                ErrorAlert.printMessage(message: error?.localizedDescription ?? "Something wrong", viewController: self)
            }
            if json != nil {
                guard let data = json else {return}
                let user = UserCoffee(data: data)
                self.loginedUser = user
                self.performSegue(withIdentifier: "currentUserSegue", sender: nil)
            }
        }
    }
    
    @IBAction func tappedOnRegistrationButton(_ sender: Any) {
        self.performSegue(withIdentifier: "registrationSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "currentUserSegue" {
            let receive = segue.destination as! CurrenUserViewController
            if let currentUser = self.loginedUser {
                receive.loginedUser = currentUser
            } else {
                print ("cant send user to CurrenUserViewController")
            }
        }
    }
}
