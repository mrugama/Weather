import Foundation
@testable import NetworkingTestUtilities
@testable import RestAPI
@testable import RestAPITestUtilities
import Testing
@testable import LandingPage

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
        let model = await viewModel.fetchWeatherData(from: "Manhattan")
        
        // Then
        #expect(model?.name == "Manhattan")
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

