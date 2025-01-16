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
            contentView
                .frame(height: 117)
                .padding(.top, 48)
                .padding([.leading, .trailing], 48)
                .background(
                    Rectangle()
                        .fill(Color(red: 242/255, green: 242/255, blue: 242/255))
                        .cornerRadius(16)
                        .padding(.top, 32)
                        .padding([.leading, .trailing], 16)
                        .overlay {
                        }
                        .onTapGesture {
                            withAnimation {
                                appState = .locationDetails(model: model, city: model.location.name)
                            }
                        }
                )
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
        VStack(alignment: .center, spacing: 13) {
            Text(model.location.name)
                .font(.title.weight(.semibold))
            Text("\(String(format: "%.0f", floor(model.current.tempF)))")
                .font(.system(size: 42, weight: .bold))
                .overlay(alignment: .topTrailing) {
                    Text("°")
                        .font(.caption2.weight(.bold))
                        .padding(.top, 8)
                        .padding(.trailing, -8)
                }
        }
        .foregroundStyle(Color(red: 44/255, green: 44/255, blue: 44/255))
    }
}
