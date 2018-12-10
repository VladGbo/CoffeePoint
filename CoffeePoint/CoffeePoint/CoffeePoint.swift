//
//  CoffeePoint.swift
//  CoffeePoint
//
//  Created by Vladyslav Horbenko on 12/10/18.
//  Copyright © 2018 Vladyslav Horbenko. All rights reserved.
//

import Foundation

struct CoffeePoint {
    private static var coffeePointId: Int
    private var listOfDrinks:[TypeOfDrink]
    var readyToPreparing: Bool
    
    init(listOfDrinks:[TypeOfDrink], readyToPreparing:Bool) {
        self.listOfDrinks = listOfDrinks
        self.readyToPreparing = readyToPreparing
        
        CoffeePoint.coffeePointId += 1
    }
}
