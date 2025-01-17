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
            AsyncImage(url: model.icon64x64URL) { pahse in
                switch pahse {
                case .success(let image):
                    image
                        .resizable()
                        .frame(width: 83, height: 67)
                default:
                    ProgressView()
                }
            }
        }
    }
    
    var cityView: some View {
        VStack(alignment: .center, spacing: 13) {
            Text(model.name)
                .font(.title.weight(.semibold))
            Text(model.tempFFormatted)
                .font(.system(size: 42, weight: .bold))
                .overlay(alignment: .topTrailing) {
                    Text(model.tempSymbol)
                        .font(.footnote.weight(.bold))
                        .padding(.top, 8)
                        .padding(.trailing, -8)
                }
        }
        .foregroundStyle(Color(red: 44/255, green: 44/255, blue: 44/255))
    }
}

extension WeatherAppState {
    
}
