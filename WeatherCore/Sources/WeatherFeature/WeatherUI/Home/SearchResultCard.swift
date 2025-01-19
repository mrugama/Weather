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
            Spacer()
        }
        .padding(.x20)
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
                        .scaledToFill()
                        .frame(width: .x82, height: .x68)
                default:
                    ProgressView()
                }
            }
        }
        .padding([.leading, .trailing], .x32)
        .padding([.top, .bottom], .x16)
        .background(
            Color.veryLightGray,
            in: RoundedRectangle(
                cornerRadius: .x16,
                style: .continuous
            )
        )
        .onTapGesture {
            withAnimation {
                appState = .locationDetails(model: model, city: model.location.name)
            }
        }
    }
    
    var cityView: some View {
        VStack(alignment: .center, spacing: .x14) {
            Text(model.name)
                .font(.title.weight(.semibold))
            Text(model.tempFFormatted)
                .font(.system(size: .x60, weight: .semibold))
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
