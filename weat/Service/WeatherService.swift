//
//  WeatherService.swift
//  weat
//
//  Created by Александр Басов on 12/2/21.
//

import Foundation
import CoreLocation

public final class WeatherService: NSObject {
    private let locationManager = CLLocationManager()
    private let APIKey = "0291579625523cace0ae80c6a6c61fdf"
    private var completionHandler: ((Weather) -> Void)?
    
    public override init() {
        super.init()
        locationManager.delegate = self
    }
    
    public func loadWeatherData(_ completionHandler: @escaping ((Weather) -> Void)) {
        self.completionHandler = completionHandler
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    public func makeDataRequest(forCordinates cordinates: CLLocationCoordinate2D) {
        guard let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(cordinates.latitude)&lon=\(cordinates.longitude)&appid=\(APIKey)&units=metric".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let url = URL(string: urlString) else { return }
        
        print("Сordinates: \(cordinates.longitude), \(cordinates.latitude)")
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else { return }
            if let response = try? JSONDecoder().decode(APIResponse.self, from: data) {
                self.completionHandler?(Weather(response: response))
                print("Response: \(response)")
            }
        }.resume()
    }
    
}

extension WeatherService: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        makeDataRequest(forCordinates: location.coordinate)
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Somithing went wrong: \(error.localizedDescription)")
    }
}


struct APIResponse: Decodable {
    let name: String
    let main: APIMain
    let weather: [APIWeather]
    let wind: APIWind
    let sys: APISys
}

struct APIMain: Decodable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
}

struct APIWind: Decodable {
    let speed: Double
}

struct APISys: Decodable {
    let sunrise: Int
    let sunset: Int
    
    enum  CodingKeys: String, CodingKey { case sunrise, sunset }
    
    let dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    var dateSunrise : String {
        let timeInterval = TimeInterval(sunrise)
        let date = Date(timeIntervalSince1970: timeInterval)
        return dateFormatter.string(from:date)
    }
    var dateSunset : String {
        let timeInterval = TimeInterval(sunset)
        let date = Date(timeIntervalSince1970: timeInterval)
        return dateFormatter.string(from:date)
    }
}

struct APIWeather: Decodable {
    let description: String
    let iconName: String
    
    enum CodingKeys: String, CodingKey {
        case description
        case iconName = "main"
    }
}
