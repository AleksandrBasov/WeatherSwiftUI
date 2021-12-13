//
//  ContentView.swift
//  weat
//
//  Created by Александр Басов on 12/2/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: WeatherViewModel
    @State private var isNight = false
    
    var body: some View {
        ZStack {
            
            BackgroundView(topColor: isNight ? .black : .blue,
                           bottomColor: isNight ? .gray : .white)
          
            VStack {
                
                HStack {
                    Sunrise(sunrise: viewModel.sunrise)
                    VStack {
                        CityTextView(cityName: viewModel.cityName)
                        MainWeatherStatusView(imageName: viewModel.weatherIcon,
                                              temp: viewModel.temperature)
                        FeelsLike(feelsLike: viewModel.temperatureFeelsLike)
                        DescriptionTextView(Description: viewModel.weatherDescription)
                    }
                    Sunset(sunset: viewModel.sunset)
                }
                HStack(spacing: 20) {
                    VStack {
                        WeatherNameCategory()
                        WeatherCategory(tempMax: viewModel.temperatureMax,
                                        tempMin: viewModel.temperatureMin,
                                        pressure: viewModel.pressure,
                                        humidity: viewModel.humidity,
                                        windSpeed: viewModel.windSpeed)
                    }
                }
                Spacer()
                Button {
                    isNight.toggle()
                } label: {
                    WeatherButton(title: isNight ? "Change Day Time To Day" : "Change Day Time To Night",
                                  textColor: .blue,
                                  backgroundColor: .white)
                    
                }
                Spacer()
            }.onAppear(perform: {
                viewModel.refresh()
            })
        }
    }
}

// MARK: - ContentView_Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: WeatherViewModel(weatherService: WeatherService()))
    }
}

// MARK: - BackgroundView
struct BackgroundView: View {
    
    var topColor: Color
    var bottomColor: Color
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [topColor, bottomColor]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

// MARK: - CityTextView
struct CityTextView: View {
    
    var cityName: String
    
    var body: some View {
        Text(cityName)
            .font(.system(size: 32, weight: .medium, design: .default))
            .foregroundColor(.white)
            .padding()
    }
}

// MARK: - MainWeatherStatusView
struct MainWeatherStatusView: View {
    
    var imageName: String
    var temp: String
    
    var body: some View {
       
        VStack(spacing: 10) {
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
            Text("\(temp)")
                .font(.system(size: 70, weight: .medium))
                .foregroundColor(.white)
        }
    }
}

// MARK: - DescriptionTextView
struct DescriptionTextView: View {
    
    var Description: String
    
    var body: some View {
        Text(Description)
            .font(.system(size: 32, weight: .medium, design: .default))
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .padding()
    }
}

// MARK: - WeatherButton
struct WeatherButton: View {
    
    var title: String
    var textColor: Color
    var backgroundColor: Color
    
    var body: some View {
        Text(title)
            .frame(width: 280, height: 50)
            .background(backgroundColor)
            .foregroundColor(textColor)
            .font(.system(size: 20, weight: .bold, design: .default))
            .cornerRadius(10)

    }
}

// MARK: - WeatherCategory
struct WeatherCategory: View {
    
    var tempMax: String
    var tempMin: String
    var pressure: String
    var humidity: String
    var windSpeed: String
    
    var body: some View {

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: 0) {

                    WeatherDay(DayOfVweak: "Temp Max", items: "thermometer.sun.fill", weatherTemperature: tempMax)
                    WeatherDay(DayOfVweak: "Temp Min", items: "thermometer.snowflake", weatherTemperature: tempMin)
                    WeatherDay(DayOfVweak: "Pressure", items: "aqi.medium", weatherTemperature: pressure)
                    WeatherDay(DayOfVweak: "Humidity", items: "drop", weatherTemperature: humidity)
                    WeatherDay(DayOfVweak: "Wind speed", items: "wind", weatherTemperature: windSpeed)
                    
                }
                .padding(.horizontal, 15)
            }
            
        }
    
}

// MARK: - WeatherNameCategory
struct WeatherNameCategory: View {
    var body: some View {
        VStack (alignment: .leading, spacing: 10){
            Text("Important information:")
                .font(.headline)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .padding(.leading, -170)
                .padding(.top, 5)
                .foregroundColor(.white)
        }
    }
}



// MARK: - WeatherDay
struct WeatherDay: View {
    
    var DayOfVweak: String
    var items: String
    var weatherTemperature: String
    
    var body: some View {
        VStack {
            Text(DayOfVweak)
                .font(.system(size: 16, weight: .medium, design: .default))
                .foregroundColor(.white)
                .padding(.leading, 15)

            Image(systemName: items)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .padding(.leading, 15)

            Text("\(weatherTemperature)")
                .font(.system(size: 28, weight: .medium))
                .foregroundColor(.white)
                .padding(.leading, 15)

        }
    }
}

// MARK: - FeelsLike
struct FeelsLike: View {
    
    var feelsLike: String
    
    var body: some View {
        Text("Feels like: \(feelsLike)")
            .foregroundColor(.white)
    }
}


// MARK: - Sunrise
struct Sunrise: View {
    
    var sunrise: String
    
    var body: some View {
        VStack {
            Image(systemName: "sunrise.fill")
            Text(sunrise)
                .foregroundColor(.white)
        }
        .frame(width: 50.0)
    }
}

// MARK: - Sunset
struct Sunset: View {
    
    var sunset: String
    
    var body: some View {
        VStack {
            Image(systemName: "sunset.fill")
            Text(sunset)
                .foregroundColor(.white)
        }
        .frame(width: 50.0)
    }
}
