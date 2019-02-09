//
//  CurrenUserModel.swift
//  CoffeeIOS
//
//  Created by Vladyslav Horbenko on 1/7/19.
//  Copyright © 2019 Vladyslav Horbenko. All rights reserved.
//

import Foundation

class CurrentUserModel {

    func decriptionAboutUser(user: UserCoffee) -> String {
        return "\(user.name) \n \(user.email)"
        
    }
    
    func listOfWorkedMachine (list:[CoffeeMachine]) -> [CoffeeMachine] {
        var res = [CoffeeMachine]()
        for machine in list {
            if machine.isWorked {
                res.append(machine)
            }
        }
        return res
    }
}
