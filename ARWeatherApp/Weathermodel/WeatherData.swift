//
//  WeatherData.swift
//  ARWeatherApp
//
//  Created by Noura Mohammad Althrowi on 24/07/1444 AH.
//

import Foundation
struct WeatherData: Codable {
    let name:String
    let main: Main
    let weather: [Weather]
}
struct Weather: Codable {
    let id: Int
}
struct Main: Codable{
    let temp:Double
}
