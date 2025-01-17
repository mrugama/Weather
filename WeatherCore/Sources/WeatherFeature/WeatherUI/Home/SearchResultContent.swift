//
//  SwiftUIView.swift
//  WeatherCore
//
//  Created by Marlon Rugama on 1/15/25.
//

import SwiftUI

struct SearchResultContent: View {
    var imageURL: URL
    var condition: String
    var temp: Double
    var humidity: Int
    var uv: Double
    var feelsLike: Double
    
    var body: some View {
        VStack {
            iconView
                .padding(.bottom, 27)
            conditionView
                .padding(.bottom, 16)
            temperatureView
                .padding(.bottom, 36)
            sectionView
            Spacer()
        }
        .padding(.top, 74)
        .padding([.leading, .trailing], 16)
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
        .foregroundStyle(Color(red: 44/255, green: 44/255, blue: 44/255))
        .fontWeight(.semibold)
    }
    
    var temperatureView: some View {
        Text("\(String(format: "%.0f", floor(temp)))")
            .foregroundStyle(Color(red: 44/255, green: 44/255, blue: 44/255))
            .font(.system(size: 70).weight(.bold))
            .overlay(alignment: .topTrailing) {
                Text("°")
                    .foregroundStyle(Color(red: 44/255, green: 44/255, blue: 44/255))
                    .font(.body.weight(.bold))
                    .padding(.top, 8)
                    .padding(.trailing, -8)
            }
    }
    
    var sectionView: some View {
        Rectangle()
            .fill(Color(red: 242/255, green: 242/255, blue: 242/255))
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
            }
    }
    
    var humidityView: some View {
        VStack(spacing: 2) {
            Text("Humidity")
                .foregroundStyle(Color(red: 196/255, green: 196/255, blue: 196/255))
                .font(.caption)
            Text(humidity, format: .percent)
                .foregroundStyle(Color(red: 154/255, green: 154/255, blue: 154/255))
                .font(.subheadline)
        }
        .font(.caption)
    }
    
    var uvView: some View {
        VStack(spacing: 2) {
            Text("UV")
                .foregroundStyle(Color(red: 196/255, green: 196/255, blue: 196/255))
                .font(.caption)
            Text(uv, format: .number.rounded(increment: 0.0))
                .foregroundStyle(Color(red: 154/255, green: 154/255, blue: 154/255))
                .font(.subheadline)
        }
        .font(.caption)
    }
    
    var feelsLikeView: some View {
        VStack(spacing: 2) {
            Text("Feels Like")
                .foregroundStyle(Color(red: 196/255, green: 196/255, blue: 196/255))
                .font(.caption)
            Text("\(String(format: "%.0f", floor(feelsLike)))°")
                .foregroundStyle(Color(red: 154/255, green: 154/255, blue: 154/255))
                .font(.subheadline)
        }
    }
}

extension SearchResultContent {
    init(_ model: WeatherModel) {
        imageURL = model.icon128x128URL
        condition = model.text
        temp = model.tempF
        humidity = model.humidity
        uv = model.uv
        feelsLike = model.feelslikeF
    }
}

#Preview {
    SearchResultContent(
        imageURL: URL(string: "https://cdn.weatherapi.com/weather/128x128/day/113.png")!,
        condition: "Brooklyn",
        temp: 26,
        humidity: 57,
        uv: 0,
        feelsLike: 21
    )
}
