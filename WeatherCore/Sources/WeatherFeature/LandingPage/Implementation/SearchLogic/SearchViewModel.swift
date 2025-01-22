import RestAPI
import SwiftUI

@MainActor
protocol SearchViewModel
where Self: Observable {
    var searchText: String { get set }
    var prompt: LocalizedStringKey { get }
    var appState: WeatherAppState { get set }
    
    func fetchWeatherData(from city: String) async -> WeatherModel?
}

@MainActor
@Observable
final class SearchViewModelImpl: SearchViewModel, Sendable {
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
