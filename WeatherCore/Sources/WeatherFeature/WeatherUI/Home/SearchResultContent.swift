//
//  SwiftUIView.swift
//  WeatherCore
//
//  Created by Marlon Rugama on 1/15/25.
//
import DecoratorUI
import SwiftUI

struct SearchResultContent: View {
    let imageURL: URL
    let condition: String
    let temp: String
    let humidityLabel: String
    let humidity: Int
    let uvLabel: String
    let uv: Double
    let feelsLikeLabel: String
    let feelsLike: String
    let tempSymbol: String
    
    var body: some View {
        VStack(spacing: .x36) {
            VStack(spacing: .x24) {
                iconView
                conditionView
                temperatureView
            }
            sectionView
            Spacer()
        }
        .padding(.top, .x72)
        .padding([.leading, .trailing], .x16)
    }
    
    var iconView: some View {
        AsyncImage(url: imageURL) { pahse in
            switch pahse {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: .x124, height: .x124)
            default:
                ProgressView()
            }
        }
    }
    
    var conditionView: some View {
        HStack {
            Text(condition)
                .font(.title)
            Image(systemName: "location.fill")
                .font(.title3)
        }
        .foregroundStyle(Color.darkGrayishBlack)
        .fontWeight(.semibold)
    }
    
    var temperatureView: some View {
        Text(temp)
            .foregroundStyle(Color.darkGrayishBlack)
            .font(.system(size: .x72).weight(.semibold))
            .overlay(alignment: .topTrailing) {
                Text(tempSymbol)
                    .foregroundStyle(Color.darkGrayishBlack)
                    .font(.body.weight(.semibold))
                    .padding(.top, .x8)
                    .padding(.trailing, -.x8)
            }
    }
    
    var sectionView: some View {
        HStack(alignment: .top, spacing: .x56) {
            humidityView
            uvView
            feelsLikeView
        }
        .padding(.x16)
        .background(
            Color.veryLightGray,
            in: RoundedRectangle(
                cornerRadius: .x16,
                style: .continuous
            )
        )
    }
    
    var humidityView: some View {
        VStack(spacing: .x2) {
            Text(humidityLabel)
                .foregroundStyle(Color.lightGray)
                .font(.caption)
            Text(humidity, format: .percent)
                .foregroundStyle(Color.mediumGray)
                .font(.subheadline)
        }
        .font(.caption)
    }
    
    var uvView: some View {
        VStack(spacing: .x2) {
            Text(uvLabel)
                .foregroundStyle(Color.lightGray)
                .font(.caption)
            Text(uv, format: .number.rounded(increment: 0.0))
                .foregroundStyle(Color.mediumGray)
                .font(.subheadline)
        }
        .font(.caption)
    }
    
    var feelsLikeView: some View {
        VStack(spacing: .x2) {
            Text(feelsLikeLabel)
                .foregroundStyle(Color.lightGray)
                .font(.caption2)
            Text("\(feelsLike)°")
                .foregroundStyle(Color.mediumGray)
                .font(.subheadline)
        }
    }
}

extension SearchResultContent {
    init(_ model: WeatherModel) {
        imageURL = model.icon128x128URL
        condition = model.text
        temp = model.tempFFormatted
        humidityLabel = model.humidityLabel
        humidity = model.humidity
        uvLabel = model.uvLabel
        uv = model.uv
        feelsLikeLabel = model.feelsLikeLabel
        feelsLike = model.feelsLikeCFormatted
        tempSymbol = model.tempSymbol
    }
}

#Preview {
    SearchResultContent(
        imageURL: URL(string: "https://cdn.weatherapi.com/weather/128x128/day/113.png")!,
        condition: "Brooklyn",
        temp: "26",
        humidityLabel: "Humidity",
        humidity: 57,
        uvLabel: "UV",
        uv: 0,
        feelsLikeLabel: "Feels like",
        feelsLike: "21",
        tempSymbol: "°"
    )
}
