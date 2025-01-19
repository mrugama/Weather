import Foundation

@dynamicMemberLookup
struct WeatherModel: Decodable, Equatable {
    let location: Location
    let current: Current
    
    subscript<T>(dynamicMember keyPath: KeyPath<Location, T>) -> T {
        return location[keyPath: keyPath]
    }
    
    subscript<T>(dynamicMember keyPath: KeyPath<Current, T>) -> T {
        return current[keyPath: keyPath]
    }
    
    struct Location: Decodable, Equatable {
        let name: String
        let country: String
    }
    
    @dynamicMemberLookup
    struct Current: Decodable, Equatable {
        let tempC: Double
        let tempF: Double
        let condition: Condition
        let humidity: Int
        let feelslikeC: Double
        let feelslikeF: Double
        let uv: Double
        
        var tempCFormatted: String {
            String(format: "%.0f", floor(tempC))
        }
        
        var tempFFormatted: String {
            String(format: "%.0f", floor(tempF))
        }
        
        var feelsLikeCFormatted: String {
            String(format: "%.0f", floor(feelslikeC))
        }
        
        var feelsLikeFFormatted: String {
            String(format: "%.0f", floor(feelslikeF))
        }
        
        var tempSymbol: String {
            "°"
        }
        
        var humidityLabel: String {
            "Humidity"
        }
        
        var uvLabel: String {
            "UV"
        }
        
        var feelsLikeLabel: String {
            "Feels like"
        }
        
        subscript<T>(dynamicMember keyPath: KeyPath<Condition, T>) -> T {
            return condition[keyPath: keyPath]
        }
        
        struct Condition: Decodable, Equatable {
            let text: String
            let icon: String
            let code: Int
            
            var icon128x128URL: URL {
                URL(string: iconSizeUrlStr(128))!
            }
            
            var icon64x64URL: URL {
                URL(string: iconSizeUrlStr(64))!
            }
            
            private func iconSizeUrlStr(_ size: Int) -> String {
                let iconName = String(icon.split(separator: "/").last ?? "113.png")
                return "https://cdn.weatherapi.com/weather/\(size)x\(size)/day/\(iconName)"
            }
        }
    }
}



