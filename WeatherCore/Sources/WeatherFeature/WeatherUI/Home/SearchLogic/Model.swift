import Foundation

struct WeatherModel: Decodable, Equatable {
    let location: Location
    let current: Current
}

struct Location: Decodable, Equatable {
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    let tzId: String
    let localtimeEpoch: Int
    let localtime: String
}

struct Current: Decodable, Equatable {
    let lastUpdatedEpoch: Int
    let lastUpdated: String
    let tempC: Double
    let tempF: Double
    let isDay: Int
    let condition: Condition
    let windMph: Double
    let windKph: Double
    let windDegree: Int
    let windDir: String
    let pressureMb: Double
    let pressureIn: Double
    let precipMm: Double
    let precipIn: Double
    let humidity: Int
    let uv: Double
    let feelslikeC: Double
    let feelslikeF: Double
}

struct Condition: Decodable, Equatable {
    let text: String
    let icon: String
    let code: Int
}
