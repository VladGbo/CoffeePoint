//
//  LoginModel.swift
//  CoffeePoint
//
//  Created by Vladyslav Horbenko on 12/12/18.
//  Copyright © 2018 Vladyslav Horbenko. All rights reserved.
//

import Foundation
import Firebase

class LoginModel {
    
    private var userName: String
    private var password: String
    private var error: Error?
    
    init(userName: String, password: String) {
        self.userName = userName
        self.password = password
    }
    
    func loginUser() -> Bool {
        var res = false
        Auth.auth().signIn(withEmail: self.userName, password: self.password) { (user, error) in
            guard let er = error else {
                res = true
                return
            }
            self.error = er
        }
        return res
    }
}
