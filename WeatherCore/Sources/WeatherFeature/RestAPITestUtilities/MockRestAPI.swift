#if DEBUG
import Foundation
import RestAPI
import Networking

public final class MockRestAPI: RestAPI, Sendable {
    private let dataLoader: DataLoader

    public init(_ dataLoader: DataLoader) {
        self.dataLoader = dataLoader
    }

    public func fetch<T: Decodable>(_ city: String) async throws -> T {
        let urlStr = "https://api.example.com/city/\(city)"
        let data = try await dataLoader.load(urlStr: urlStr)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: data)
    }

    public func fetchAsset(icon: String) async throws -> Data {
        let urlStr = "https://api.example.com/asset/\(icon)"
        return try await dataLoader.load(urlStr: urlStr)
    }
}

public func provideMockWeatherData() -> Data {
    let url = Bundle.module.url(forResource: "weather", withExtension: "json")!

    return try! Data(contentsOf: url)
}

public func provideMockWeatherModel<T: Decodable>() -> T {
    let url = Bundle.module.url(forResource: "weather", withExtension: "json")!

    let data = try! Data(contentsOf: url)
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return try! decoder.decode(T.self, from: data)
}
#endif
