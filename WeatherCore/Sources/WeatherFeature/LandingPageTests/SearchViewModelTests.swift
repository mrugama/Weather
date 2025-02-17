import Foundation
import NetworkingTestUtilities
import RestAPI
import RestAPITestUtilities
@testable import LandingPage
import Testing

@Suite("Weather ViewModel")
@MainActor
struct WeatherViewModelTests {
    let viewModel: SearchViewModel
    let restAPI: RestAPI
    let dataLoader: MockDataLoader
    
    init() {
        dataLoader = MockDataLoader()
        restAPI = ConcreteRestAPIService().provideRestAPI(dataLoader)
        viewModel = SearchViewModelImpl(restAPI)
    }
    
    @Test("Verify initial state")
    func verifyInitialState() async throws {
        // Given-When-Then
        #expect(viewModel.searchText == "")
        #expect(viewModel.appState == .noLocationSelected)
    }
    
    @Test("Fetch from online successfully")
    func fetchFromOnlineSuccessfully() async throws {
        // Given
        dataLoader.dataToReturn = provideMockWeatherData()
        
        // When
        let model: WeatherModel? = await viewModel.fetchWeatherData(from: "Manhattan")
        
        // Then
        #expect(model?.name == "Manhattan")
        #expect(model?.tempCFormatted == "-4")
        #expect(model?.tempFFormatted == "25")
        #expect(model?.feelsLikeCFormatted == "-9")
        #expect(model?.feelsLikeFFormatted == "15")
        #expect(model?.tempSymbol == "°")
        #expect(model?.humidityLabel == "Humidity")
        #expect(model?.uvLabel == "UV")
        #expect(model?.feelsLikeLabel == "Feels like")
        #expect(model?.icon64x64URL.absoluteString == "https://cdn.weatherapi.com/weather/64x64/day/113.png")
        #expect(model?.icon128x128URL.absoluteString == "https://cdn.weatherapi.com/weather/128x128/day/113.png")
        #expect(viewModel.appState != .somethingWentWrong(error: "Unable to fetch data"))
    }
    
    @Test("Fetch from online failed")
    func fetchFromOnlineFailed() async throws {
        // Given
        dataLoader.dataToReturn = nil
        dataLoader.errorToThrow = URLError(.badServerResponse)
        
        // When
        let model: WeatherModel? = await viewModel.fetchWeatherData(from: "Manhattan")
        
        // Then
        #expect(model == nil)
        #expect(viewModel.appState == .somethingWentWrong(error: "The operation couldn’t be completed. (NSURLErrorDomain error -1011.)"))
    }
}

