//
//  WeatherNetworkManager.swift
//  ARWeatherApp
//
//  Created by Noura Mohammad Althrowi on 24/07/1444 AH.
//

import Foundation

public class WeatherNetworkManager: ObservableObject{
    
    @Published var recievedWeatherData:Weathermodel?
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=ac1c3a518178ddc48d79635c00ed1d4c&units=metric"
    //fetch data
    public func fetchData(cityName: String){
        
        let weatherURLString = "\(weatherURL)&q=\(cityName)"
        //URL
        if let url = URL(string: weatherURLString){
            
            //URL session
            let session = URLSession(configuration: .default)
            
            //fetching task
            let task = session.dataTask(with: url) { (data,response,error) in
                
                //error handle
                if error != nil {
                    fatalError("\(String(describing: error?.localizedDescription))")
                }
                
                //parse JASON
                if let recievedData = data {
                    
                    //decoded
                    if let decodedData = self.decodeJSONData(recievedData: recievedData){
                        //convert to usable form
                        let weatherData = self.convertDecodedDataToUsableForm(decodedData: decodedData)
                        //pass data
                        self.passData(weatherData: weatherData)
                    }
                }
            }
            task.resume()
        }
    }
    private func decodeJSONData(recievedData: Data) -> WeatherData?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: recievedData)
            return decodedData
        }catch{
            return nil
        }
    }
    private func convertDecodedDataToUsableForm(decodedData:WeatherData) -> Weathermodel{
        let weatherData = Weathermodel(cityName: decodedData.name, temperature: decodedData.main.temp , conditionId: decodedData.weather[0].id)
        return weatherData
    }
    
    
    
    //pass data
    private func passData(weatherData:Weathermodel){
        recievedWeatherData = weatherData
    }
}
