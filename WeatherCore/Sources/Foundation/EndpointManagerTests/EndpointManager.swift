import Foundation
import Testing
@testable import EndpointManager

@Suite("EndpointManager Tests")
struct EndpointManagerTests {
    
    @Test("City Search Endpoint")
    func citySearchEndpoint() async throws {
        // Given
        let configuration = EndpointConfiguration.search(.city("NewYork"))
        let endpointManager = MockEndpointManager(configuration)
        
        // When
        let request = try endpointManager()
        
        // Then
        #expect(request.url?.absoluteString == "https://api.example.com/search/city/NewYork")
    }
    
    @Test("Asset Search Endpoint")
    func assetSearchEndpoint() async throws {
        // Given
        let configuration = EndpointConfiguration.search(.asset("1234"))
        let endpointManager = MockEndpointManager(configuration)
        
        // When
        let request = try endpointManager()
        
        // Then
        #expect(request.url?.absoluteString == "https://api.example.com/search/asset/1234")
    }
    
    // MARK: - Mock EndpointManager implementation
    final class MockEndpointManager: EndpointManager, @unchecked Sendable {
        private let endpoint: EndpointConfiguration

        required init(_ endpoint: EndpointConfiguration) {
            self.endpoint = endpoint
        }

        func callAsFunction() throws -> URLRequest {
            switch endpoint {
            case .search(let resource):
                switch resource {
                case .city(let cityName):
                    return URLRequest(url: URL(string: "https://api.example.com/search/city/\(cityName)")!)
                case .asset(let assetName):
                    return URLRequest(url: URL(string: "https://api.example.com/search/asset/\(assetName)")!)
                }
            }
        }
    }
}
