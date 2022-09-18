//
//  ClockData.swift
//  worldClock
//
//  Created by suhail on 02/09/22.
//

import Foundation

struct ClockData: Decodable{
    
    let datetime: String
    let timezone_name: String
    let timezone_location: String
    let requested_location: String
    let latitude: Double
    let longitude: Double
    
    
    
}
