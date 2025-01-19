import Foundation
import RestAPI
import Networking

public final class MockRestAPI: RestAPI, @unchecked Sendable {
    private let dataLoader: DataLoader

    public init(_ dataLoader: DataLoader) {
        self.dataLoader = dataLoader
    }

    public func fetch<T: Decodable>(_ city: String) async throws -> T {
        let url = URL(string: "https://api.example.com/city/\(city)")!
        let request = URLRequest(url: url)
        let data = try await dataLoader.load(urlRequest: request)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: data)
    }

    public func fetchAsset(icon: String) async throws -> Data {
        let url = URL(string: "https://api.example.com/asset/\(icon)")!
        let request = URLRequest(url: url)
        return try await dataLoader.load(urlRequest: request)
    }
}

public func provideWeatherData() -> Data {
    let url = Bundle.module.url(forResource: "weather", withExtension: "json")!

    return try! Data(contentsOf: url)
}

public func provideWeatherModel<T: Decodable>() -> T {
    let url = Bundle.module.url(forResource: "weather", withExtension: "json")!

    let data = try! Data(contentsOf: url)
    return try! JSONDecoder().decode(T.self, from: data)
}
