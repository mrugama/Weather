import Foundation
import WTLogging

struct ConcreteDataLoader: DataLoader {
    
    func load(urlStr: String) async throws -> Data {
        let logger = WTLogger(module: .networking)
        guard let url = URL(string: urlStr) else {
            logger.error("\(NetworkError.invalidURL)")
            throw NetworkError.invalidURL
        }
        let urlRequest = URLRequest(url: url)
        guard let (data, response) = try? await URLSession.shared.data(for: urlRequest) else {
            throw NetworkError.requestFailed(statusCode: 0)
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            logger.error("\(NetworkError.invalidResponse)")
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            logger.error("\(NetworkError.requestFailed(statusCode: httpResponse.statusCode))")
            throw NetworkError.requestFailed(statusCode: httpResponse.statusCode)
        }
        
        return data
    }
}
