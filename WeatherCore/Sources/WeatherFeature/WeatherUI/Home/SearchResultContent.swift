//
//  SwiftUIView.swift
//  WeatherCore
//
//  Created by Marlon Rugama on 1/15/25.
//

import SwiftUI

struct SearchResultContent: View {
    var imageUrl: String
    var city: String
    var temp: Double
    var humidity: Int
    var uv: Double
    var feelLike: Double
    
    private var imageURL: URL {
        let iconName = String(imageUrl.split(separator: "/").last ?? "")
        let iconUrl = "https://cdn.weatherapi.com/weather/128x128/day/\(iconName)"
        return URL(string: iconUrl)!
    }
    
    var tempFormatted: String {
        let measure = Measurement<UnitTemperature>(value: temp, unit: .fahrenheit)
        return measure.formatted()
    }
    var feelLikeFormatted: String {
        let measure = Measurement<UnitTemperature>(value: feelLike, unit: .fahrenheit)
        return measure.formatted()
    }
    
    var body: some View {
        VStack(spacing: 24) {
            iconView
            cityView
            temperatureView
            sectionView
        }
        .padding()
    }
    
    var iconView: some View {
        AsyncImage(url: imageURL) { pahse in
            switch pahse {
            case .success(let image):
                image
                    .resizable()
                    .frame(width: 160, height: 160)
            default:
                ProgressView()
                    .frame(width: 160, height: 160)
            }
        }
    }
    
    var cityView: some View {
        HStack {
            Text(city)
            Image(systemName: "location.fill")
        }
        .font(.title)
        .fontWeight(.semibold)
    }
    
    var temperatureView: some View {
        Text(tempFormatted)
            .font(.system(size: 64).bold())
    }
    
    var sectionView: some View {
        Rectangle()
            .fill(Color.gray.quaternary)
            .cornerRadius(16)
            .frame(height: 75)
            .overlay {
                HStack {
                    humidityView
                    Spacer()
                    uvView
                    Spacer()
                    feelsLikeView
                }
                .padding()
                .foregroundStyle(.gray)
            }
    }
    
    var humidityView: some View {
        VStack {
            Text("Humidity")
                .font(.subheadline)
            Text(humidity, format: .percent)
        }
    }
    
    var uvView: some View {
        VStack {
            Text("UV")
                .font(.subheadline)
            Text(uv, format: .number.rounded(increment: 0.0))
        }
    }
    
    var feelsLikeView: some View {
        VStack {
            Text("Feels Like")
                .font(.subheadline)
            Text(feelLikeFormatted)
        }
    }
}

extension SearchResultContent {
    init(_ model: WeatherModel) {
        imageUrl = model.current.condition.icon
        city = model.location.name
        temp = model.current.tempF
        humidity = model.current.humidity
        uv = model.current.uv
        feelLike = model.current.feelslikeF
    }
}

#Preview {
    SearchResultContent(
        imageUrl: "cloud.sun.bolt",
        city: "Brooklyn",
        temp: 26,
        humidity: 57,
        uv: 0,
        feelLike: 21
    )
}
