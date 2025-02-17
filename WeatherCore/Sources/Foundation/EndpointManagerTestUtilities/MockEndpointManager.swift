#if DEBUG
import EndpointManager
import Foundation

// MARK: - Mock EndpointManager implementation
public final class MockEndpointManager: EndpointManager, @unchecked Sendable {
    private let endpoint: EndpointConfiguration

    public init(_ endpoint: EndpointConfiguration) {
        self.endpoint = endpoint
    }

    public func callAsFunction() throws -> String {
        switch endpoint {
        case .search(let resource):
            switch resource {
            case .city(let cityName):
                return "https://api.example.com/search/city/\(cityName)"
            case .asset(let assetName):
                return "https://cdn.example.com/asset/\(assetName)"
            }
        }
    }
}
#endif
