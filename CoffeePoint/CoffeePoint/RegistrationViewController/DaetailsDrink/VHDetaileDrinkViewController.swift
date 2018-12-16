//
//  VHDetaileDrinkViewController.swift
//  CoffeePoint
//
//  Created by Vladyslav Horbenko on 12/15/18.
//  Copyright © 2018 Vladyslav Horbenko. All rights reserved.
//

import UIKit

class VHDetaileDrinkViewController: UIViewController {
    var titleText: String?

    @IBOutlet weak var titleDrinkLabel: UILabel!
    @IBOutlet weak var drinkImageView: UIImageView!
    @IBOutlet weak var descriptionDrinkLabel: UITextView!
    
    private let listOfDrink = [ "Americano":("Americano", "americano", "The drink consists of a single or double-shot of espresso brewed with added water."),
        "Espresso":("Espresso", "espresso", "Espresso is made by forcing very hot water under high pressure through finely ground compacted coffee."),
        "Cappuccino":("Cappuccino", "capuchino", "As cappuccino is defined today, in addition to a double shot of espresso, the most important factors in preparing a cappuccino are the texture and temperature of the milk."),
        "Latte":("Latte", "latte", "Amazing coffee with best milk."),
        "Tea":("Tea", "tea", "Tea is an aromatic beverage commonly prepared by pouring hot or boiling water over cured leaves of the Camellia sinensis."),
        "Chocolate":("Chocolate", "chocolate", "Is a heated drink consisting of shaved chocolate, melted chocolate or cocoa powder, heated milk or water, and usually a sweetener.")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let key = titleText {
            let currentDrink = VHDetailsModel(listOfDrinks: self.listOfDrink, key: key)
            fillAllData(list: currentDrink.getInfo())
        }

    }
  
    @IBAction func tappedPrepareDrinkButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func fillAllData(list:(String, String, String)) {
        self.titleDrinkLabel.text = list.0
        self.drinkImageView.image = UIImage(named: list.1)
        self.descriptionDrinkLabel.text = list.2
    }
}
