//
//  SwiftUIView.swift
//  WeatherCore
//
//  Created by Marlon Rugama on 1/15/25.
//

import DecoratorUI
import SwiftUI

struct SearchResultCard: View {
    var model: WeatherModel
    @Binding var appState: WeatherAppState
    
    var body: some View {
        VStack {
            contentView
                .frame(height: .x116)
                .padding(.top, .x48)
                .padding([.leading, .trailing], .x48)
                .background(
                    Rectangle()
                        .fill(Color.veryLightGray)
                        .cornerRadius(.x16)
                        .padding(.top, .x32)
                        .padding([.leading, .trailing], .x16)
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
                        .frame(width: .x82, height: .x68)
                default:
                    ProgressView()
                }
            }
        }
    }
    
    var cityView: some View {
        VStack(alignment: .center, spacing: .x14) {
            Text(model.name)
                .font(.title.weight(.semibold))
            Text(model.tempFFormatted)
                .font(.system(size: .x42, weight: .bold))
                .overlay(alignment: .topTrailing) {
                    Text(model.tempSymbol)
                        .font(.footnote.weight(.bold))
                        .padding(.top, .x8)
                        .padding(.trailing, -.x8)
                }
        }
        .foregroundStyle(Color.darkGrayishBlack)
    }
}
