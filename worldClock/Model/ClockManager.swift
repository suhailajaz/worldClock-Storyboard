//
//  ClockManager.swift
//  worldClock
//
//  Created by suhail on 02/09/22.
//

import Foundation
import UIKit

protocol ClockManagerDelegate: UITextFieldDelegate{
    func didFetchTime(_ clockManager: ClockManager ,time: ClockModel)
    func didFailWithError(error: Error)
}
struct ClockManager{
    
    var delegate: ClockManagerDelegate?
    
    let timeUrl = "https://timezone.abstractapi.com/v1/current_time?api_key=c00f5fc842a44c0285efd263375faf08&location"
    
    func fetchTime(cityName: String){
        
        let updatedCityName = cityName.replacingOccurrences(of: " ", with: "+")
        let urlString = "\(timeUrl)=\(updatedCityName)"
        performRequest(with: urlString)
        print("Checkpoin ABC")
        return
    }
    
    
    
    //Networking Function
    func performRequest(with urlString: String){
        //1. Create a URL
        print("Inside perform request: \(urlString)")
        if let url = URL(string: urlString){
            
            //2. Create a session
            let session = URLSession(configuration: .default)
            print("checkpoin B")
            //3. Give the session a task
            
            let task = session.dataTask(with: url) { data, response, error in
                print("checkpoin c")
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    // print("something happened")
                    return
                }
                
                if let safeData = data{
                    if let clock = self.parseJSON(safeData){
                        
                        self.delegate?.didFetchTime(self, time: clock)
                        print("Intermission")
                    }
                }
            }
            //4.Start the task
            task.resume()
        }
        
    }
    
    func parseJSON(_ clockData: Data)->ClockModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(ClockData.self, from: clockData)
            let dAndT = decodedData.datetime
            let timezoneName = decodedData.timezone_name
            let reqLoc = decodedData.requested_location
            let lat = decodedData.latitude
            let lon = decodedData.longitude
            let timeZoneLocation = decodedData.timezone_location
            let country = ClockModel(datetime: dAndT, timezone_name: timezoneName, timezone_location: timeZoneLocation, requested_location: reqLoc, latitude: lat, longitude: lon)
            print("inside parseJson")
            
            return country
            
        }catch{
            delegate?.didFailWithError(error: error)
            //print("something happened")
            return nil
        }
    }
    
    
    
    
    
}





