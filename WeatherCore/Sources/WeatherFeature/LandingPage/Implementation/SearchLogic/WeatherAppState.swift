import Foundation

enum WeatherAppState: Equatable {
    case noLocationSelected,
         searchingLocationBy(city: String),
         locationSelected(WeatherModel),
         locationDetails(model: WeatherModel, city: String),
         somethingWentWrong(error: String)
}
