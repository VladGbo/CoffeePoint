//
//  VHDetailsModel.swift
//  CoffeePoint
//
//  Created by Vladyslav Horbenko on 12/15/18.
//  Copyright © 2018 Vladyslav Horbenko. All rights reserved.
//

import UIKit

class VHDetailsModel: NSObject {
    
    private let listOfDrinks: [String: (String, String,String)]
    private let key: String
    
    init(listOfDrinks: [String: (String, String,String)], key: String) {
        self.listOfDrinks = listOfDrinks
        self.key = key
    }
    
    func getInfo() -> (String, String,String) {
        if let list = self.listOfDrinks[key] {
            return list
        }
            return ("","","")
    }
}
