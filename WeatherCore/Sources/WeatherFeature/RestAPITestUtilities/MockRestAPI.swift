#if DEBUG
import Foundation

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
