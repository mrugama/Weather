//
//  SwiftUIView.swift
//  WeatherCore
//
//  Created by Marlon Rugama on 1/15/25.
//

import SwiftUI

struct HomePage: View {
    @State private var viewModel: SearchViewModel
    @AppStorage("SelectedCity") var selectedCity: String?
    var body: some View {
        NavigationStack {
            if viewModel.appState == .showResultView, let model = viewModel.resultWeather {
                SearchResultCard(
                    city: model.location.name,
                    temp: model.current.tempF,
                    imageUrl: model.current.condition.icon,
                    appState: $viewModel.appState
                )
            } else if viewModel.appState == .showSelectedCityView, let model = viewModel.resultWeather {
                SearchResultContent(model)
            } else {
                SearchContentUnavailableView()
            }
        }
        .onAppear {
            if let city = selectedCity {
                viewModel.searchText = city
                Task {
                    await viewModel.fetchWeatherData()
                    viewModel.appState = .showSelectedCityView
                }
            }
        }
        .task(id: viewModel.appState) {
            switch viewModel.appState {
            case .savedCity, .searchCity:
                await viewModel.fetchWeatherData()
            case .showSelectedCityView:
                selectedCity = viewModel.searchText
            default: break
            }
        }
        .searchable(text: $viewModel.searchText, prompt: viewModel.prompt)
        .onSubmit(of: .search) {
            viewModel.appState = .searchCity
        }
    }
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
    }
}
