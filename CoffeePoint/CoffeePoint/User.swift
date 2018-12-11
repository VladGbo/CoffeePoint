//
//  user.swift
//  CoffeePoint
//
//  Created by Vladyslav Horbenko on 12/10/18.
//  Copyright © 2018 Vladyslav Horbenko. All rights reserved.
//

import Foundation

struct User {
    var userName: String
    var userEmail: String
    var userPassword: String
    
    init(userName: String, userEmail: String, userPassword: String) {
        self.userName = userName
        self.userEmail = userEmail
        self.userPassword = userPassword
        
    }
    
}
