//
//  TypeOfDrink.swift
//  CoffeePoint
//
//  Created by Vladyslav Horbenko on 12/10/18.
//  Copyright © 2018 Vladyslav Horbenko. All rights reserved.
//

import Foundation

struct TypeOfDrink {
    private var drinkName:String
    private var isMilk: Bool
    private var sugar: Int
    
    init(drinkName:String, isMilk:Bool, sugar:Int) {
        self.drinkName = drinkName
        self.isMilk = isMilk
        self.sugar = sugar
    }
}
