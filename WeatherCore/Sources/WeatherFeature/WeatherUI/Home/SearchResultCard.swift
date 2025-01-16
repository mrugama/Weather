//
//  SwiftUIView.swift
//  WeatherCore
//
//  Created by Marlon Rugama on 1/15/25.
//

import SwiftUI

struct SearchResultCard: View {
    var model: WeatherModel
    @Binding var appState: WeatherAppState
    
    private var imageURL: URL {
        let iconName = String(model.current.condition.icon.split(separator: "/").last ?? "")
        let iconUrl = "https://cdn.weatherapi.com/weather/128x128/day/\(iconName)"
        return URL(string: iconUrl)!
    }
    private var tempFormatted: String {
        let measure = Measurement<UnitTemperature>(value: model.current.tempF, unit: .fahrenheit)
        return measure.formatted()
    }
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
                    appState = .locationDetails(model)
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
            Text(model.location.name)
                .font(.title.bold())
            Text(tempFormatted)
                .font(.system(size: 48, weight: .bold))
        }
    }
}
