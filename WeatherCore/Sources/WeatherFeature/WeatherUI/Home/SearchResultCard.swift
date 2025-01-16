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
                        .padding([.leading, .trailing], 36)
                        .padding(.top, 32)
                }
                .onTapGesture {
                    withAnimation {
                        appState = .locationDetails(model: model, city: model.location.name)
                    }
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
                        .frame(width: 83, height: 67)
                default:
                    ProgressView()
                        .frame(width: 83, height: 67)
                }
            }
        }
    }
    
    var cityView: some View {
        VStack {
            Text(model.location.name)
                .font(.title3.weight(.semibold))
            Text("\(String(format: "%.0f", floor(model.current.tempF)))°")
                .font(.system(size: 60, weight: .bold))
        }
    }
}
