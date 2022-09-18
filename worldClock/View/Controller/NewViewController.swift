//
//  NewViewController.swift
//  worldClock
//
//  Created by suhail on 02/09/22.
//

import UIKit

class NewViewController: UIViewController {

    
    var clockManager = ClockManager()
    
    @IBOutlet weak var requestedLocationLabel: UILabel!
    @IBOutlet weak var dAndTLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var timezoneNameLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var textFieldLabel: UITextField!
    @IBOutlet weak var timezoneLocationLabe: UILabel!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldLabel.delegate = self
        clockManager.delegate = self
       // textFieldLabel.delegate = self
    }
    
    @IBAction func searchButtonTappeedd(_ sender: UIButton) {
       
       // clockManager.delegate = self
        textFieldLabel.endEditing(true)
    }
    /*@IBAction func searchTapped(sender: UIButton) {
        textFieldLabel.endEditing(true)
    }*/
}


// MARK: - WeatherManagerDelegate Extension
extension NewViewController: ClockManagerDelegate{
    
    
    func didFetchTime(_ clockManager: ClockManager ,time: ClockModel) {
        DispatchQueue.main.async {
            self.requestedLocationLabel.text = time.requested_location
            self.dAndTLabel.text = time.datetime
            self.latitudeLabel.text = String(time.latitude)
            self.longitudeLabel.text = String(time.longitude)
            self.timezoneLocationLabe.text = time.timezone_location
            self.timezoneNameLabel.text = time.timezone_name
            print("success")
            //self.textFieldLabel.text = .none
        }
    }
    
    func didFailWithError(error: Error){
        print(error)
    }
    
    
}

// MARK: - UITextFieldDelegate Extension
extension NewViewController: UITextFieldDelegate{
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldLabel.endEditing(true)
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
        
        if let city = textFieldLabel.text{
            print("sbra")
            self.clockManager.fetchTime(cityName: city)
            
            
            
            
            print("first checkpoint working")
        }
        
        textField.text = .none
        
    }
    
}

