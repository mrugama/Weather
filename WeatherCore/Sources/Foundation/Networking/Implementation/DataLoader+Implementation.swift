import Foundation
import OSLog
import WTLogging

struct ConcreteDataLoader: DataLoader {
    
    func load(urlRequest: URLRequest) async throws -> Data {
        let logger = Logger(module: .networking)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
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
