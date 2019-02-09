//
//  CoffeeMachine.swift
//  CoffeeIOS
//
//  Created by Vladyslav Horbenko on 1/7/19.
//  Copyright © 2019 Vladyslav Horbenko. All rights reserved.
//

import Foundation
struct CoffeeMachine {
    var name: String
    var adrress: String
    var isWorked:Bool
    
    init(data:[String:Any]) {
        self.name = data["name"] as! String
        self.adrress = data["adrress"] as! String
        self.isWorked = data["isWorked"] as! Bool
    }
}
