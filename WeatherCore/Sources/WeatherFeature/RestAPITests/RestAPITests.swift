import Foundation
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
        self.restAPI = ConcreteRestAPIService().provideRestAPI(mockDataLoader)
    }
    
    @Test("Fetch City Successfully")
    func fetchCitySuccessfully() async throws {
        // Given
        let weatherData = provideMockWeatherData()
        mockDataLoader.dataToReturn = weatherData
        
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
        
        // When
        let data = try await restAPI.fetchAsset(icon: "icon123")
        
        // Then
        #expect(data == assetData)
    }
    
    @Test("Fetch Asset Failure")
    func fetchAssetFailure() async throws {
        // Given
        mockDataLoader.errorToThrow = URLError(.badServerResponse)
        
        do {
            // When
            _ = try await restAPI.fetchAsset(icon: "icon123")
            
            // Then if fails
            Issue.record("Expected error to be thrown.")
        } catch {
            // Then
            #expect(error is URLError)
            #expect(error as! URLError == URLError(.badServerResponse))
        }
    }
    
    struct WeatherModel:Decodable {
        let location: Location
        let current: Current
        
        struct Location: Decodable {
            let name: String
        }
        
        struct Current: Decodable {
            let condition: Condition
            
            struct Condition: Decodable {
                let text: String
            }
        }
    }
}
