import Foundation
import Testing
import NetworkingTestUtilities
@testable import Networking

@Suite("Networking Tests")
struct DataLoaderTests {
    var dataLoader: MockDataLoader
    
    init() {
        self.dataLoader = MockDataLoader()
    }
    
    @Test("Load data success")
    func loadDataSuccess() async throws {
        // Given
        let expectedData = "Success Data".data(using: .utf8)
        dataLoader.dataToReturn = expectedData
        let urlRequest = URLRequest(url: URL(string: "https://example.com")!)
        
        // When
        let data = try await dataLoader.load(urlRequest: urlRequest)
        
        #expect(data == expectedData)
    }
    
    @Test("Load data failure")
    func loadDataFailure() async throws {
        // Given
        let expectedError = URLError(.badURL)
        dataLoader.errorToThrow = expectedError
        let urlRequest = URLRequest(url: URL(string: "https://example.com")!)
        
        // When/Then
        do {
            let _ = try await dataLoader.load(urlRequest: urlRequest)
            Issue.record("Expected error to be thrown.")
        } catch {
            #expect(error.localizedDescription == expectedError.localizedDescription)
        }
    }
}
