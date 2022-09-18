
//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit


class ClockViewController: UIViewController {
    
    var clockManager = ClockManager()
    @IBOutlet weak var locationRequestLabel: UILabel!
    
    @IBOutlet weak var textFieldd: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       clockManager.delegate = self
        textFieldd.delegate = self
    }
    
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        textFieldd.endEditing(true)
    }
    
}

// MARK: - UITextFieldDelegate Extension
extension ClockViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldd.endEditing(true)
        //print(searchTextField.text!)
        return true
        
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != " "{
            return true
        }else{
            textField.placeholder = "Type Something"
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let place = textField.text{
            clockManager.fetchTime(cityName: place)
        }
        
        textField.text = " "
    }
    
}

// MARK: - WeatherManagerDelegate Extension
extension ClockViewController: ClockManagerDelegate{
   
    
    func didFetchTime(_ clockManger: ClockManager ,time: ClockModel) {
        DispatchQueue.main.async {
            self.locationRequestLabel.text = time.requested_location
    }
    }
    func didFailWithError(error: Error){
        print(error)
    }
    
    


}
