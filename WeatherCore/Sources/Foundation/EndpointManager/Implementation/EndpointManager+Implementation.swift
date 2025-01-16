import Foundation

enum EndpointError: LocalizedError, Equatable {
    case invalidURL
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        }
    }
}

struct ConcreteEndpointManager: EndpointManager {
    private var apiKey: String {
        "PASTE-YOUR-KEYAPI-HERE"
    }
    
    private var configuration: EndpointConfiguration
    
    init(_ configuration: EndpointConfiguration) {
        self.configuration = configuration
    }
    
    func callAsFunction() throws -> URLRequest {
        guard let url = makeURL() else { throw EndpointError.invalidURL }
        return URLRequest(url: url)
    }
}

// MARK: - URL maker
extension ConcreteEndpointManager {
    fileprivate func makeURL() -> URL? {
        var components = URLComponents()
        components.scheme = "http"
        var queryItems = [URLQueryItem]()
        
        switch configuration {
            case .search(let resource):
            switch resource {
            case .city(let name):
                components.host = "api.weatherapi.com"
                queryItems.append(URLQueryItem(name: "key", value: apiKey))
                queryItems.append(URLQueryItem(name: "q", value: name))
                queryItems.append(URLQueryItem(name: "aqi", value: "no"))
                components.path = "/v1/current.json"
            case .asset(let iconFullPath):
                components.scheme = "https"
                let icon = getIcon(iconFullPath)
                components.host = "cdn.weatherapi.com/weather/128x128/day/\(icon)"
                components.host = icon
            }
        }
        components.queryItems = queryItems
        return components.url
    }
    
    // MARK: - Helper function
    private func getIcon(_ fullPath: String) -> String {
        return String(fullPath.split(separator: "/").last ?? "")
    }
}
