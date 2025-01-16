import RestAPI
import SwiftUI

enum WeatherAppState: Equatable {
    case noLocationSelected,
         searchingLocationBy(city: String),
         locationSelected(WeatherModel),
         locationDetails(model: WeatherModel, city: String),
         somethingWentWrong(error: String)
}

@MainActor
@Observable
final class SearchViewModel {
    var searchText: String = ""
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
            withAnimation {
                appState = .somethingWentWrong(
                    error: error.localizedDescription
                )
            }
        }
        return nil
    }
}
