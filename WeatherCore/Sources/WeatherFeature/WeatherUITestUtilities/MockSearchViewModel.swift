#if DEBUG
import Foundation
import Model
import RestAPI
import SwiftUI
import WeatherUI

@MainActor
public final class MockSearchViewModel: SearchViewModel, Sendable {
    public var searchText: String = ""
    public var prompt: LocalizedStringKey = "Search Location"
    public var appState: WeatherUI.WeatherAppState = .noLocationSelected
    private let restAPI: RestAPI
    
    public func fetchWeatherData(from city: String) async -> WeatherModel? {
        do {
            return try await restAPI.fetch(city)
        } catch {
            withAnimation {
                appState = .somethingWentWrong(
                    error: "Unable to fetch data"
                )
            }
        }
        return nil
    }
    
    public init(_ restAPI: RestAPI) {
        self.restAPI = restAPI
    }
}
#endif
