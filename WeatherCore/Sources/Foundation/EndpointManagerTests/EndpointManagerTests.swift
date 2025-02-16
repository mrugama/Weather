@testable import EndpointManager
@testable import EndpointManagerTestUtilities
import Testing

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
        #expect(request.url?.absoluteString == "https://cdn.example.com/asset/1234")
    }
}
