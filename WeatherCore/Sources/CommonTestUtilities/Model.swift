import Foundation

public struct City: Decodable {
    public let name: String
    public let population: Int
    
    public init(name: String, population: Int) {
        self.name = name
        self.population = population
    }
}

