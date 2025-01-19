import Foundation

public struct MockWeatherModel: Decodable {
    public let location: Location
    public let current: Current
    
    public init(location: Location, current: Current) {
        self.location = location
        self.current = current
    }
    
    public struct Location: Decodable {
        public let name: String
        public let country: String
    }
    
    public struct Current: Decodable {
        public let tempC: Double
        public let tempF: Double
        public let condition: Condition
        public let humidity: Int
        public let feelslikeC: Double
        public let feelslikeF: Double
        public let uv: Double
        
        public struct Condition: Decodable {
            public let text: String
            public let icon: String
            public let code: Int
        }
    }
}

