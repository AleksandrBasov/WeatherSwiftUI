//
//  weatApp.swift
//  weat
//
//  Created by Александр Басов on 12/2/21.
//

import SwiftUI

@main
struct weatApp: App {
    var body: some Scene {
        WindowGroup {
            let weatherService = WeatherService()
            let viewModel = WeatherViewModel(weatherService: weatherService)
            ContentView(viewModel: viewModel)
        }
    }
}
