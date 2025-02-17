import Foundation
@testable import Networking
import Testing

@Suite("Networking Tests")
struct DataLoaderTests {
    var dataLoader: DataLoader
    
    init() {
        self.dataLoader = ConcreteDataLoaderService().provideDataLoader()
    }
    
    @Test("Load data success")
    func loadDataSuccess() async throws {
        // Given
        let urlStr = "https://github.com/mrugama/Weather/blob/master/coverage.json"
        
        // When
        let data = try await dataLoader.load(urlStr: urlStr)
        
        #expect(!data.isEmpty)
    }
    
    @Test("Empty url string")
    func emptyURLString() async throws {
        // Given
        let urlStr = ""
        
        // When/Then
        do {
            let _ = try await dataLoader.load(urlStr: urlStr)
            Issue.record("Expected error to be thrown.")
        } catch (let error as NetworkError) {
            #expect(error == .invalidURL)
            #expect(error.localizedDescription == "Invalid URL")
        }
    }
    
    @Test("Bad url string")
    func badURLString() async throws {
        // Given
        let urlStr = "htp://some.x"
        
        // When/Then
        do {
            let _ = try await dataLoader.load(urlStr: urlStr)
            Issue.record("Expected error to be thrown.")
        } catch (let error as NetworkError) {
            #expect(error == .requestFailed(statusCode: 0))
        }
    }
    
    @Test("Bad url string")
    func noFoundURL() async throws {
        // Given
        let urlStr = "https://www.google.com/404"
        
        // When/Then
        do {
            let _ = try await dataLoader.load(urlStr: urlStr)
            Issue.record("Expected error to be thrown.")
        } catch (let error as NetworkError) {
            #expect(error == .requestFailed(statusCode: 404))
        }
    }
}
