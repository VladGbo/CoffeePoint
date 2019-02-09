//
//  TypeOfDrink.swift
//  CoffeeIOS
//
//  Created by Vladyslav Horbenko on 1/7/19.
//  Copyright © 2019 Vladyslav Horbenko. All rights reserved.
//

import Foundation

struct TypeOfDrink {
    var name:String
    var cost:Int
    
    init(data: [String: Any]) {
        self.name = data["name"] as! String
        self.cost = data["cost"] as! Int
    }
    
}
