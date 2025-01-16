import Foundation

public protocol DataLoader
where Self: Sendable {
    func load(urlRequest: URLRequest) async throws -> Data
}

public protocol DataLoaderService
where Self: Sendable {
    func provideDataLoader() -> DataLoader
}

public struct ConcreteDataLoaderService: DataLoaderService {
    public func provideDataLoader() -> DataLoader {
        ConcreteDataLoader()
    }
    
    public init () {}
}
