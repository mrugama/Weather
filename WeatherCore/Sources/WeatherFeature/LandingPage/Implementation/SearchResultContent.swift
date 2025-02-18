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
        HStack(alignment: .top) {
            VStack(spacing: .x24) {
                iconView
                conditionView
                temperatureView
                sectionView
                    .padding([.top], .x12)
            }
        }
        .padding(.x16)
        .padding(.top, .x56)
    }
    
    var iconView: some View {
        AsyncImage(url: imageURL) { image in
            image
                .resizable()
                .scaledToFill()
                .clipped()
        } placeholder: {
            ProgressView()
                .controlSize(.extraLarge)
        }
        .frame(width: .x124, height: .x124)
        .accessibilityLabel(Text("Weather icon"))
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
        .accessibilityLabel(Text("Condition \(condition)"))
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
            .accessibilityLabel(Text("Tempuerature \(temp) \(tempSymbol) Farneheit"))
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
        .accessibilityLabel(Text("Weather condition section"))
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
        .frame(minWidth: .x60, minHeight: .x60)
        .accessibilityLabel(
            Text("Humidity level ") +
            Text(humidity, format: .percent)
        )
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
        .frame(minWidth: .x60, minHeight: .x60)
        .accessibilityLabel(
            Text("Ultra violet index ") +
            Text(uv, format: .number.rounded(increment: 0.0))
        )
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
        .frame(minWidth: .x60, minHeight: .x60)
        .accessibilityLabel(Text("Feels like"))
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
        feelsLike = model.feelsLikeFFormatted
        tempSymbol = model.tempSymbol
    }
}

#if DEBUG
import RestAPITestUtilities
#endif

#Preview(traits: .sizeThatFitsLayout) {
    SearchResultContent(provideMockWeatherModel())
}
