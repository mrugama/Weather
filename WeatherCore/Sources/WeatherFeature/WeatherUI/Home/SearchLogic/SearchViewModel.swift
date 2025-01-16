import Foundation
import RestAPI
import SwiftUI

enum WeatherAppState: Equatable {
    case noLocationSelected,
         searchingLocationBy(city: String),
         locationSelected(WeatherModel),
         locationDetails(WeatherModel),
         somethingWentWrong(error: String)
}

@MainActor
@Observable
final class SearchViewModel {
    var weatherIconData: Data?
    let prompt: LocalizedStringKey = "Search Location"
    var appState: WeatherAppState = .noLocationSelected
    
    private var restAPI: RestAPI
    
    init(_ restAPI: RestAPI) {
        self.restAPI = restAPI
    }
    
    func fetchWeatherData(from city: String) async -> WeatherModel? {
        do {
            return try await restAPI.fetch(city)
        } catch {
            appState = .somethingWentWrong(
                error: error.localizedDescription
            )
        }
        return nil
    }
}
