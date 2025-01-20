import Foundation
import Model
import NetworkingTestUtilities
@testable import RestAPI
import RestAPITestUtilities
import Testing

@Suite("RestAPI Tests")
struct RestAPITests {
    let mockDataLoader: MockDataLoader
    let restAPI: RestAPI
    
    init() async throws {
        self.mockDataLoader = MockDataLoader()
        self.restAPI = MockRestAPI(mockDataLoader)
    }
    
    @Test("Fetch City Successfully")
    func fetchCitySuccessfully() async throws {
        // Given
        let weatherData = provideMockWeatherData()
        mockDataLoader.dataToReturn = weatherData
        
        let restAPI = MockRestAPI(mockDataLoader)
        
        // When
        let city: WeatherModel = try await restAPI.fetch("Manhattan")
        
        // Then
        #expect(city.location.name == "Manhattan")
        #expect(city.current.condition.text == "Clear")
    }
    
    @Test("Fetch City Failure")
    func fetchCityFailure() async throws {
        // Given
        mockDataLoader.errorToThrow = URLError(.badServerResponse)
        
        let restAPI = MockRestAPI(mockDataLoader)
        
        // When & Then
        do {
            _ = try await restAPI.fetchAsset(icon: "icon123")
            Issue.record("Expected error to be thrown.")
        } catch {
            #expect(error is URLError)
            #expect(error as! URLError == URLError(.badServerResponse))
        }
    }
    
    @Test("Fetch Asset Successfully")
    func fetchAssetSuccessfully() async throws {
        // Given
        let assetData = Data([0x01, 0x02, 0x03])
        mockDataLoader.dataToReturn = assetData
        
        let restAPI = MockRestAPI(mockDataLoader)
        
        // When
        let data = try await restAPI.fetchAsset(icon: "icon123")
        
        // Then
        #expect(data == assetData)
    }
    
    @Test("Fetch Asset Failure")
    func fetchAssetFailure() async throws {
        mockDataLoader.errorToThrow = URLError(.badServerResponse)
        
        let restAPI = MockRestAPI(mockDataLoader)
        
        do {
            _ = try await restAPI.fetchAsset(icon: "icon123")
            Issue.record("Expected error to be thrown.")
        } catch {
            #expect(error is URLError)
            #expect(error as! URLError == URLError(.badServerResponse))
        }
    }
}
