import Foundation
import Networking
import EndpointManager

enum RestAPIError: LocalizedError, Equatable {
    case invalidDataType
}

struct ConcreteRestAPI: RestAPI {
    private let dataLoader: any DataLoader
    private let endpointManagerService: ConcreteEndpointManagerService
    
    init(_ dataLoader: any DataLoader) {
        self.dataLoader = dataLoader
        endpointManagerService = ConcreteEndpointManagerService()
    }
    
    func fetch<T>(_ city: String) async throws -> T where T : Decodable {
        let endpointRequest = endpointManagerService.provideEndpointManager(.search(.city(city)))
        let data = try await dataLoader.load(urlRequest: endpointRequest())
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let decodedData = try? jsonDecoder.decode(T.self, from: data) else {
            throw RestAPIError.invalidDataType
        }
        return decodedData
    }
    
    func fetchAsset(icon: String) async throws -> Data {
        let configuration: EndpointConfiguration = .search(.asset(icon))
        let endpointRequest = endpointManagerService.provideEndpointManager(configuration)
        return try await dataLoader.load(urlRequest: endpointRequest())
    }
}
