//
//  SwiftUIView.swift
//  WeatherCore
//
//  Created by Marlon Rugama on 1/15/25.
//

import SwiftUI

struct HomePage: View {
    @State private var viewModel: SearchViewModel
    @State private var searchText: String = ""
    @AppStorage("SelectedCity") var selectedCity: String?
    var body: some View {
        NavigationStack {
            switch viewModel.appState {
            case .noLocationSelected:
                SearchContentUnavailableView()
            case .searchingLocationBy(city: let city):
                ProgressView {
                    Text("Serching city: \(city)")
                }
            case .locationSelected(let model):
                SearchResultCard(model: model, appState: $viewModel.appState)
            case .locationDetails(let model, _):
                SearchResultContent(model)
            case .somethingWentWrong(let error):
                ContentUnavailableView(error, image: "exclamationmark.triangle.fill")
            }
        }
        .task {
            if let city = selectedCity,
               let location = await viewModel.fetchWeatherData(from: city) {
                viewModel.appState = .locationDetails(model: location, city: city)
            }
        }
        .task(id: viewModel.appState) {
            if case .searchingLocationBy(let city) = viewModel.appState,
               let location = await viewModel.fetchWeatherData(from: city) {
                viewModel.appState = .locationSelected(location)
            } else if case .locationDetails(_, let city) = viewModel.appState {
                selectedCity = city
            }
        }
        .searchable(text: $searchText, prompt: viewModel.prompt)
        .onSubmit(of: .search) {
            viewModel.appState = .searchingLocationBy(city: searchText)
        }
    }
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
    }
}
