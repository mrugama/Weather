import Foundation
import Testing
import CommonTestUtilities
@testable import RestAPI
import RestAPITestUtilities
import EndpointManagerTestUtilities
import NetworkingTestUtilities

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
        let cityJSON = """
                {
                    "name": "New York",
                    "population": 8000000
                }
                """
        let cityData = Data(cityJSON.utf8)
        mockDataLoader.dataToReturn = cityData
        
        let restAPI = MockRestAPI(mockDataLoader)
        
        // When
        let city: City = try await restAPI.fetch("NewYork")
        
        // Then
        #expect(city.name == "New York")
        #expect(city.population == 8000000)
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
        } catch {
            #expect(error is URLError)
            #expect(error as! URLError == URLError(.badServerResponse))
        }
    }
}
