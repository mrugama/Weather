import Foundation
import SwiftUI
import Model

public enum WeatherAppState: Equatable {
    case noLocationSelected,
         searchingLocationBy(city: String),
         locationSelected(WeatherModel),
         locationDetails(model: WeatherModel, city: String),
         somethingWentWrong(error: String)
}

@MainActor
public protocol SearchViewModel
where Self: Observable {
    var searchText: String { get set }
    var prompt: LocalizedStringKey { get }
    var appState: WeatherAppState { get set }
    
    func fetchWeatherData(from city: String) async -> WeatherModel?
}
