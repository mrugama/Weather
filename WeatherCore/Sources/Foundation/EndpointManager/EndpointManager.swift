import Foundation

public enum EndpointConfiguration: Sendable {
    public enum Resource : Sendable {
        case city(String),
             asset(String)
    }
    
    case search(_ resource: EndpointConfiguration.Resource)
}

public protocol EndpointManager
where Self: Sendable {
    init(_ endpoint: EndpointConfiguration)
    
    func callAsFunction() throws -> String
}

public protocol EndpointManagerService where Self: Sendable {
    func provideEndpointManager(_ configuration: EndpointConfiguration) -> EndpointManager
}

public struct ConcreteEndpointManagerService: EndpointManagerService {
    public func provideEndpointManager(_ configuration: EndpointConfiguration) -> EndpointManager {
        ConcreteEndpointManager(configuration)
    }
    
    public init() {}
}
