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
        contentView
            .padding(.x20)
    }
    
    var contentView: some View {
        HStack {
            cityView
            Spacer()
            AsyncImage(url: model.icon64x64URL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .clipped()
            } placeholder: {
                ProgressView()
                    .controlSize(.extraLarge)
            }
            .frame(width: .x68, height: .x68)
            .accessibilityLabel("Weahter image")
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
        .accessibilityLabel(Text("Search result card for \(model.name)"))
    }
    
    var cityView: some View {
        VStack(alignment: .center, spacing: .x14) {
            Text(model.name)
                .font(.title.weight(.semibold))
                .accessibilityLabel(Text("City \(model.name)"))
            Text(model.tempFFormatted)
                .font(.system(size: .x60, weight: .semibold))
                .overlay(alignment: .topTrailing) {
                    Text(model.tempSymbol)
                        .font(.footnote.weight(.bold))
                        .padding(.top, .x8)
                        .padding(.trailing, -.x8)
                }
                .accessibilityLabel(Text("Temperature \(model.tempFFormatted) fahrenheit"))
        }
        .foregroundStyle(Color.darkGrayishBlack)
    }
}

#if DEBUG
import RestAPITestUtilities
#endif
#Preview(traits: .sizeThatFitsLayout) {
    SearchResultCard(
        model: provideMockWeatherModel(),
        appState: .constant(.noLocationSelected)
    )
}
