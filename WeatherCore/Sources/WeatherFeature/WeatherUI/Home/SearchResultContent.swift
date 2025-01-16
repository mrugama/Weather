//
//  SwiftUIView.swift
//  WeatherCore
//
//  Created by Marlon Rugama on 1/15/25.
//

import SwiftUI

struct SearchResultContent: View {
    var imageUrl: String
    var condition: String
    var temp: Double
    var humidity: Int
    var uv: Double
    var feelsLike: Double
    
    private var imageURL: URL {
        let iconName = String(imageUrl.split(separator: "/").last ?? "")
        let iconUrl = "https://cdn.weatherapi.com/weather/128x128/day/\(iconName)"
        return URL(string: iconUrl)!
    }
    
    var body: some View {
        VStack(spacing: 24) {
            iconView
            conditionView
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
                    .frame(width: 124, height: 124)
            default:
                ProgressView()
                    .frame(width: 124, height: 124)
            }
        }
    }
    
    var conditionView: some View {
        HStack {
            Text(condition)
                .font(.title)
            Image(systemName: "location.fill")
                .font(.title2)
        }
        .fontWeight(.semibold)
    }
    
    var temperatureView: some View {
        Text("\(String(format: "%.0f", floor(temp)))°")
            .font(.system(size: 70).bold())
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
            Text(humidity, format: .percent)
        }
        .font(.caption)
    }
    
    var uvView: some View {
        VStack {
            Text("UV")
            Text(uv, format: .number.rounded(increment: 0.0))
        }
        .font(.caption)
    }
    
    var feelsLikeView: some View {
        VStack {
            Text("Feels Like")
            Text("\(String(format: "%.0f", floor(feelsLike)))°")
        }
        .font(.caption)
    }
}

extension SearchResultContent {
    init(_ model: WeatherModel) {
        imageUrl = model.current.condition.icon
        condition = model.current.condition.text
        temp = model.current.tempF
        humidity = model.current.humidity
        uv = model.current.uv
        feelsLike = model.current.feelslikeF
    }
}

#Preview {
    SearchResultContent(
        imageUrl: "cloud.sun.bolt",
        condition: "Brooklyn",
        temp: 26,
        humidity: 57,
        uv: 0,
        feelsLike: 21
    )
}
