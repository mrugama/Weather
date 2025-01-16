//
//  SwiftUIView.swift
//  WeatherCore
//
//  Created by Marlon Rugama on 1/15/25.
//

import SwiftUI

struct SearchResultCard: View {
    var city: String
    var temp: Double
    var imageUrl: String
    private var imageURL: URL {
        let iconName = String(imageUrl.split(separator: "/").last ?? "")
        let iconUrl = "https://cdn.weatherapi.com/weather/128x128/day/\(iconName)"
        return URL(string: iconUrl)!
    }
    private var tempFormatted: String {
        let measure = Measurement<UnitTemperature>(value: temp, unit: .fahrenheit)
        return measure.formatted()
    }
    @Binding var appState: WeatherAppState
    var body: some View {
        VStack {
            Rectangle()
                .fill(Color.gray.tertiary)
                .cornerRadius(16)
                .frame(height: 117)
                .padding([.leading, .trailing, .top], 16)
                .overlay {
                    contentView
                        .frame(maxWidth: .infinity)
                        .padding([.leading, .trailing], 28)
                        .padding(.top, 16)
                }
                .onTapGesture {
                    appState = .showSelectedCityView
                }
            Spacer()
        }
    }
    
    var contentView: some View {
        HStack {
            cityView
            Spacer()
            AsyncImage(url: imageURL) { pahse in
                switch pahse {
                case .success(let image):
                    image
                        .resizable()
                        .frame(width: 128, height: 128)
                default:
                    ProgressView()
                        .frame(width: 128, height: 128)
                }
            }
        }
    }
    
    var cityView: some View {
        VStack {
            Text(city)
                .font(.title.bold())
            Text(tempFormatted)
                .font(.system(size: 48, weight: .bold))
        }
    }
}

#Preview {
    SearchResultCard(
        city: "Mumbai",
        temp: 15,
        imageUrl: "https://cdn.weatherapi.com/weather/128x128/day/113.png",
        appState: .constant(.idle))
}
