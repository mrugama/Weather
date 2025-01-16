import Foundation
import RestAPI
import SwiftUI

enum WeatherAppState: Equatable {
    case idle,
         savedCity,
         searchCity,
         showResultView,
         showSelectedCityView
}

@MainActor
@Observable
final class SearchViewModel {
    var searchText: String = ""
    var resultWeather: WeatherModel? {
        didSet {
            appState = .showResultView
        }
    }
    var weatherIconData: Data?
    let prompt: LocalizedStringKey = "Search Location"
    var appState: WeatherAppState = .idle
    var output: String?
    
    private var restAPI: RestAPI
    
    init(_ restAPI: RestAPI) {
        self.restAPI = restAPI
    }
    
    func fetchWeatherData() async {
        do {
            resultWeather = try await restAPI.fetch(searchText)
        } catch {
            output = error.localizedDescription
        }
    }
}
