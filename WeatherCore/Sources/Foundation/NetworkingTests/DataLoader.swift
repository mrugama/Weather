import Foundation
import Testing
@testable import Networking

@Suite("Networking Tests")
struct NetworkingTests {
    
    struct DataLoaderTests {
        var dataLoader: MockDataLoader
        
        init() {
            self.dataLoader = MockDataLoader()
        }
        
        @Test("Load data with success")
        func loadDataSuccess() async throws {
            // Given
            let expectedData = "Success Data".data(using: .utf8)
            dataLoader.dataToReturn = expectedData
            let urlRequest = URLRequest(url: URL(string: "https://example.com")!)
            
            // When
            let data = try await dataLoader.load(urlRequest: urlRequest)
            
            #expect(data == expectedData)
        }
        
        @Test("Data failure")
        func loadDataFailure() async throws {
            // Given
            let expectedError = URLError(.badURL)
            dataLoader.errorToThrow = expectedError
            let urlRequest = URLRequest(url: URL(string: "https://example.com")!)
            
            // When/Then
            do {
                let _ = try await dataLoader.load(urlRequest: urlRequest)
                Issue.record("Expected to throw, but didn't")
            } catch {
                #expect(error.localizedDescription == expectedError.localizedDescription)
            }
        }
    }
    
    // MARK: - Mock DataLoader implementation
    final class MockDataLoader: DataLoader, @unchecked Sendable {
        var dataToReturn: Data?
        var errorToThrow: Error?
        
        func load(urlRequest: URLRequest) async throws -> Data {
            if let error = errorToThrow {
                throw error
            }
            return dataToReturn ?? Data()
        }
    }
}
