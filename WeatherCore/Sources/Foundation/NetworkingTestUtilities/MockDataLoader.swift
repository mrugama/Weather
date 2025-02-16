import Foundation
import Networking

// MARK: - Mock DataLoader implementation
public final class MockDataLoader: DataLoader, @unchecked Sendable {
    public var dataToReturn: Data?
    public var errorToThrow: Error?
    
    public init() {}
    
    public func load(urlRequest: URLRequest) async throws -> Data {
        if let error = errorToThrow {
            throw error
        }
        return dataToReturn ?? Data()
    }
}
