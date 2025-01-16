//
//  WeatherApp.swift
//  Weather
//
//  Created by Marlon Rugama on 1/15/25.
//

import SwiftUI
import WeatherUI
import RestAPI

@main
struct WeatherApp: App {
    var body: some Scene {
        WindowGroup {
            ViewProvider.weatherPage(
                restAPI: Self.provideRestAPIService()
            )
        }
    }
    
    static private func provideRestAPIService() -> RestAPI {
        return ConcreteRestAPIService().provideRestAPI()
    }
}
