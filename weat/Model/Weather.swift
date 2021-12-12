//
//  Weather.swift
//  weat
//
//  Created by Александр Басов on 12/2/21.
//

import Foundation

public struct Weather {
    
    let city: String
    let temperature: String
    let description: String
    let iconName: String
    let tempFeelsLike: String
    let tempMin: String
    let tempMax: String
    let pressurE: String
    let humiditY: String
    let windSpeed: String
    let sunRise: String
    let sunSet: String
    
    
 
    init(response: APIResponse) {
        city = response.name
        temperature = "\(Int(response.main.temp))"
        description = response.weather.first?.description ?? ""
        iconName = response.weather.first?.iconName ?? ""
        tempFeelsLike = "\(Int(response.main.feels_like))"
        tempMin = "\(Int(response.main.temp_min))"
        tempMax = "\(Int(response.main.temp_max))"
        pressurE = "\(Int(response.main.pressure))"
        humiditY = "\(Int(response.main.humidity))"
        windSpeed = "\(Double(response.wind.speed))" 
        sunSet = "\(response.sys.dateSunset)"
        sunRise = "\(response.sys.dateSunrise)"
    }
}


