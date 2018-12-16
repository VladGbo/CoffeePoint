//
//  VHPersonalUserInfoViewController.swift
//  CoffeePoint
//
//  Created by Vladyslav Horbenko on 12/11/18.
//  Copyright © 2018 Vladyslav Horbenko. All rights reserved.
//

import UIKit
import Firebase

class VHPersonalUserInfoViewController: UIViewController {

    @IBOutlet weak var nameOfUserLabel: UILabel!
    private var drink: String?
    private var error:String = ""{
        didSet{
            VHInfoSystemAlert.errorInfo(title: "ERROR", message: self.error, viewController: self)
        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserData()
    }
    
    private func loadUserData(){
        let user = Auth.auth().currentUser
        guard let userName = user?.displayName else {return}
        self.nameOfUserLabel.text = "HI, \(userName)"
    }

    @IBAction func tappedChoiceCoffee(_ sender: UIButton) {
        self.drink = sender.currentTitle
        self.performSegue(withIdentifier: "suegueCoffeeInfo", sender: nil)
    }
    
    @IBAction func tappedLeftBarButton(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            dismiss(animated: true, completion: nil)
            
        } catch {
            self.error = "Log out was failed"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let receive = segue.destination as!VHDetaileDrinkViewController
        if let text = self.drink{
        receive.titleText = text
        } else {
            self.error = "trable with segue"
        }
    }
    
}
