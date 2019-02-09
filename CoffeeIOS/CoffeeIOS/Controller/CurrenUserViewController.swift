//
//  CurrenUserViewController.swift
//  CoffeeIOS
//
//  Created by Vladyslav Horbenko on 1/6/19.
//  Copyright © 2019 Vladyslav Horbenko. All rights reserved.
//

import UIKit

class CurrenUserViewController: UIViewController {

    @IBOutlet weak var infoUserText:          UITextView!
    @IBOutlet weak var receptPickerTextField: UITextView!
    
    var loginedUser:                          UserCoffee?

    var pickedDrink:                          TypeOfDrink?
    var coffeeMachine:                        String?
    
    private let userModel = CurrentUserModel()
    var listOfDrinks = [TypeOfDrink]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ud = UserDefaults.standard
        ud.removeObject(forKey: "qrCoffeMachine")
        layerForinfoUserText()
        fillDescriptionUser()
        createPicker()
        listOfCoffeDrink()
        createToolBar()
    }
    
    private func createPicker(){
        let userPicker = UIPickerView()
        userPicker.delegate = self
        self.receptPickerTextField.inputView = userPicker
    }
    
    private func createToolBar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Прийнято", style: .plain, target: self, action: #selector(dismissKeyBoard))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        self.receptPickerTextField.inputAccessoryView = toolBar
    }
    
    @objc private func dismissKeyBoard() {
        view.endEditing(true)
    }
    
    private func layerForinfoUserText() {
        self.infoUserText.isUserInteractionEnabled = false
        self.infoUserText.layer.borderWidth = 1.0
        self.infoUserText.layer.cornerRadius = 5.0
        self.infoUserText.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    private func fillDescriptionUser() {
        if let user = self.loginedUser {
            let fill = CurrentUserModel()
            infoUserText.text = fill.decriptionAboutUser(user: user)
        } else {
            print("error fiil description User")
        }
    }
    
    private func listOfCoffeDrink() {
        guard let request = NetworkServices(url: "http://31fdcf07.ngrok.io/iosusercoffeerecepts/") else {
            print ("error with list of coffee drinks")
            return
        }
        request.getInfoFromService { (json, error) in
            if error != nil {
                print("Error: cant downloads coffee drinks: \(error?.localizedDescription ?? "")")
            }
            if let jsonList = json {
                print(jsonList)
                for i:[String:Any] in jsonList {
                    let drink = TypeOfDrink(data: i)
                        self.listOfDrinks.append(drink)
                }
            }
        }
    }
    
    private func printOnText(){
        self.receptPickerTextField.text = "\(self.pickedDrink?.name ?? ""). Приготувати?"
        let ud = UserDefaults.standard
        if ud.string(forKey: "qrCoffeMachine") == nil{
            performSegue(withIdentifier: "QRCodeSegue", sender: nil)
        }
    }
    
    @IBAction func tappedOnLogOut(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tappedOnPrepareOrder(_ sender: UIButton) {
        let ud = UserDefaults.standard
        guard let request = NetworkServices(url: "http://31fdcf07.ngrok.io/ioscreateorder/"),
            let userId = loginedUser?.idUser,
            let titleCoffeeMachine = ud.string(forKey: "qrCoffeMachine"),
            let titleDrink = pickedDrink?.name else {
            print ("error with creating order")
            return
        }
        let data = "idUser=\(userId)&titleMachine=\(titleCoffeeMachine)&titleDrink=\(titleDrink)"
        print(data)
        request.login(data: data) { (response, error) in
            if error != nil {
                ErrorAlert.printMessage(message: "Oops! \(error?.localizedDescription ?? "")", viewController: self)
            }
            if let _ = response?.values {
                ErrorAlert.printMessage(message: "\(titleDrink) зараз готується", viewController: self)
            }
        }
    }
}

extension CurrenUserViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        if component == 0 {
            return self.listOfDrinks.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            return "\(self.listOfDrinks[row].name) Вартість:\(self.listOfDrinks[row].cost)"
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0{
            self.pickedDrink = self.listOfDrinks[row]
        }
        printOnText()
    }
}

