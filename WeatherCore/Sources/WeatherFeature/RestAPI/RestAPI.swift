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
    func provideRestAPI() -> RestAPI
}

public struct ConcreteRestAPIService: RestAPIService {
    private let dataLoader: DataLoader
    public func provideRestAPI() -> RestAPI {
        ConcreteRestAPI(dataLoader)
    }
    
    public init() {
        let dataLoaderService = ConcreteDataLoaderService()
        dataLoader = dataLoaderService.provideDataLoader()
    }
}
