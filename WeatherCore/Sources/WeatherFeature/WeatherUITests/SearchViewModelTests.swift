import Foundation
import Testing
@testable import WeatherUI
import RestAPI
import RestAPITestUtilities
import Model
import WeatherUITestUtilities
import Networking
import NetworkingTestUtilities

@Suite("Weather ViewModel")
@MainActor
struct WeatherViewModelTests {
    let viewModel: SearchViewModel
    let restAPI: RestAPI
    let dataLoader: MockDataLoader
    
    init() {
        dataLoader = MockDataLoader()
        restAPI = MockRestAPI(dataLoader)
        viewModel = MockSearchViewModel(restAPI)
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
        dataLoader.dataToReturn = provideWeatherData()
        // When
        let model = await viewModel.fetchWeatherData(from: "Manhattan")
        
        #expect(model?.name == "Manhattan")
        #expect(viewModel.appState != .somethingWentWrong(error: "Unable to fetch data"))
    }
    
    @Test("Fetch from online failed")
    func fetchFromOnlineFailed() async throws {
        dataLoader.dataToReturn = nil
        dataLoader.errorToThrow = URLError(.badServerResponse)
        let model: WeatherModel? = await viewModel.fetchWeatherData(from: "Manhattan")
        
        #expect(model == nil)
        #expect(viewModel.appState == .somethingWentWrong(error: "Unable to fetch data"))
    }
}

