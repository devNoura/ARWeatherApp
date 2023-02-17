//
//  Weathermodel.swift
//  ARWeatherApp
//
//  Created by Noura Mohammad Althrowi on 24/07/1444 AH.
//

import Foundation
struct Weathermodel {
    
    let cityName: String
    let temperature: Double
    let conditionId: Int
    
    var conditionName: String{
        
        switch conditionId {
        case 200...232:
            return "thunder"
        case 300...321:
            return "rainy"
        case 500...531:
            return "rainy"
        case 600...622:
            return "snow"
        case 701...781:
            return "fog"
        case 800:
            return "sunny"
        case 801...804:
            return "thunder"
        default:
            return "normal"
            
        }
    }
}
