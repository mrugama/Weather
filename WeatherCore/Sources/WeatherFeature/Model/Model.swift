import Foundation

@dynamicMemberLookup
public struct WeatherModel: Decodable, Equatable, Sendable {
    public let location: Location
    public let current: Current
    
    public init(location: Location, current: Current) {
        self.location = location
        self.current = current
    }
    
    public subscript<T>(dynamicMember keyPath: KeyPath<Location, T>) -> T {
        return location[keyPath: keyPath]
    }
    
    public subscript<T>(dynamicMember keyPath: KeyPath<Current, T>) -> T {
        return current[keyPath: keyPath]
    }
    
    public struct Location: Decodable, Equatable, Sendable {
        public let name: String
        public let country: String
        
        public init(name: String, country: String) {
            self.name = name
            self.country = country
        }
    }
    
    @dynamicMemberLookup
    public struct Current: Decodable, Equatable, Sendable {
        public let tempC: Double
        public let tempF: Double
        public let condition: Condition
        public let humidity: Int
        public let feelslikeC: Double
        public let feelslikeF: Double
        public let uv: Double
        
        public init(tempC: Double, tempF: Double, condition: Condition, humidity: Int, feelslikeC: Double, feelslikeF: Double, uv: Double) {
            self.tempC = tempC
            self.tempF = tempF
            self.condition = condition
            self.humidity = humidity
            self.feelslikeC = feelslikeC
            self.feelslikeF = feelslikeF
            self.uv = uv
        }
        
        public var tempCFormatted: String {
            String(format: "%.0f", floor(tempC))
        }
        
        public var tempFFormatted: String {
            String(format: "%.0f", floor(tempF))
        }
        
        public var feelsLikeCFormatted: String {
            String(format: "%.0f", floor(feelslikeC))
        }
        
        public var feelsLikeFFormatted: String {
            String(format: "%.0f", floor(feelslikeF))
        }
        
        public var tempSymbol: String {
            "°"
        }
        
        public var humidityLabel: String {
            "Humidity"
        }
        
        public var uvLabel: String {
            "UV"
        }
        
        public var feelsLikeLabel: String {
            "Feels like"
        }
        
        public subscript<T>(dynamicMember keyPath: KeyPath<Condition, T>) -> T {
            return condition[keyPath: keyPath]
        }
        
        public struct Condition: Decodable, Equatable, Sendable {
            public let text: String
            public let icon: String
            public let code: Int
            
            public init(text: String, icon: String, code: Int) {
                self.text = text
                self.icon = icon
                self.code = code
            }
            
            public var icon128x128URL: URL {
                URL(string: iconSizeUrlStr(128))!
            }
            
            public var icon64x64URL: URL {
                URL(string: iconSizeUrlStr(64))!
            }
            
            private func iconSizeUrlStr(_ size: Int) -> String {
                let iconName = String(icon.split(separator: "/").last ?? "113.png")
                return "https://cdn.weatherapi.com/weather/\(size)x\(size)/day/\(iconName)"
            }
        }
    }
}

