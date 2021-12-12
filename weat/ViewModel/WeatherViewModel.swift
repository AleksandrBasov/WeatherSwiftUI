//
//  WeatherViewModel.swift
//  weat
//
//  Created by Александр Басов on 12/2/21.
//

import Foundation

private let defaultIcon = "sparkles"
private let iconMap = [
    "Drizzle" : "cloud.drizzle.fill",
    "Thunderstorm" : "cloud.bolt.rain.fill",
    "Rain" : "cloud.rain.fill",
    "Snow" : "cloud.snow.fill",
    "Clear" : "sun.max.fill",
    "Clouds" : "cloud.fill",
    "Mist" : "smoke.fill",
    "few clouds" : "cloud.sun.fill",
    "Tornado" : "tornado",
    "Haze" : "cloud.fog.fill",
    "Smoke" : "smoke.fill"]



public class WeatherViewModel: ObservableObject {
    @Published var cityName: String = "City name"
    @Published var temperature: String = "--°C"
    @Published var weatherDescription: String = "Weather description"
    @Published var weatherIcon: String = defaultIcon
    @Published var temperatureFeelsLike: String = "--°C"
    @Published var temperatureMin: String = "--°C"
    @Published var temperatureMax: String = "--°C"
    @Published var pressure: String = "-- hPa"
    @Published var humidity: String = "--%"
    @Published var windSpeed: String = "-- meter/sec"
    @Published var sunrise: String = "--"
    @Published var sunset: String = "--"
    
    public let weatherService: WeatherService
    
    public init (weatherService: WeatherService) {
        self.weatherService = weatherService
    }
    
    public func refresh() {
        weatherService.loadWeatherData { weather in
            DispatchQueue.main.async {
                self.cityName = weather.city
                self.temperature = "\(weather.temperature)°C"
                self.weatherDescription = weather.description.capitalized
                self.weatherIcon = iconMap[weather.iconName] ?? defaultIcon
                self.temperatureFeelsLike = "\(weather.tempFeelsLike)°C"
                self.temperatureMin = "\(weather.tempMin)°C"
                self.temperatureMax = "\(weather.tempMax)°C"
                self.pressure = "\(weather.pressurE) hPa"
                self.humidity = "\(weather.humiditY)%"
                self.windSpeed = "\(weather.windSpeed) m/s"
                self.sunrise = "\(weather.sunRise)"
                self.sunset = "\(weather.sunSet)"
            }
        }
    }
}

