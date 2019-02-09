//
//  UserCoffee.swift
//  CoffeeIOS
//
//  Created by Vladyslav Horbenko on 1/5/19.
//  Copyright © 2019 Vladyslav Horbenko. All rights reserved.
//

import Foundation

struct UserCoffee {
    var idUser:Int
    var name:String
    var email:String
    
    init (data: [String:Any]) {
        self.idUser = data["id"] as! Int
        self.name = data["username"] as! String
        self.email = data["email"] as! String
    }
}
