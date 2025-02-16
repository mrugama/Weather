#if DEBUG
import EndpointManager
import Foundation

// MARK: - Mock EndpointManager implementation
public final class MockEndpointManager: EndpointManager, @unchecked Sendable {
    private let endpoint: EndpointConfiguration

    public init(_ endpoint: EndpointConfiguration) {
        self.endpoint = endpoint
    }

    public func callAsFunction() throws -> URLRequest {
        switch endpoint {
        case .search(let resource):
            switch resource {
            case .city(let cityName):
                return URLRequest(url: URL(string: "https://api.example.com/search/city/\(cityName)")!)
            case .asset(let assetName):
                return URLRequest(url: URL(string: "https://cdn.example.com/asset/\(assetName)")!)
            }
        }
    }
}
#endif
