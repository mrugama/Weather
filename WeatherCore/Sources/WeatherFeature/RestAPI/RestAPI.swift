import Foundation
import Networking

public protocol RestAPI
where Self: Sendable {
    
    init(_ dataLoader: DataLoader)
    
    func fetch<T: Decodable>(_ city: String) async throws -> T
    func fetchAsset(icon: String) async throws -> Data
}

public protocol RestAPIService
where Self: Sendable {
    func provideRestAPI(_ dataLoader: DataLoader) -> RestAPI
}

public struct ConcreteRestAPIService: RestAPIService {
    public func provideRestAPI(_ dataLoader: DataLoader) -> RestAPI {
        ConcreteRestAPI(dataLoader)
    }
    
    public init() { }
}
