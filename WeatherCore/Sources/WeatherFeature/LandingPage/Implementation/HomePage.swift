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
            switch viewModel.appState {
            case .noLocationSelected:
                SearchContentUnavailableView()
            case .searchingLocationBy(city: let city):
                ProgressView {
                    Text("Serching city: \(city)")
                }
            case .locationSelected(let model):
                VStack {
                    SearchResultCard(
                        model: model,
                        appState: $viewModel.appState
                    )
                    Spacer()
                }
            case .locationDetails(let model, _):
                VStack {
                    SearchResultContent(model)
                    Spacer()
                }
            case .somethingWentWrong(let error):
                ContentUnavailableView {
                    Label(
                        "Something went wrong",
                        systemImage: "exclamationmark.triangle.fill"
                    )
                } description: { Text(error) }
            }
        }
        .task {
            if let city = selectedCity,
               let location = await viewModel.fetchWeatherData(from: city) {
                withAnimation {
                    viewModel.appState = .locationDetails(model: location, city: city)
                }
            }
        }
        .task(id: viewModel.appState) {
            if case .searchingLocationBy(let city) = viewModel.appState,
               let location = await viewModel.fetchWeatherData(from: city) {
                withAnimation {
                    viewModel.appState = .locationSelected(location)
                }
            } else if case .locationDetails(_, let city) = viewModel.appState {
                selectedCity = city
            }
        }
        .searchable(text: $viewModel.searchText, prompt: viewModel.prompt)
        .onSubmit(of: .search) {
            withAnimation {
                viewModel.appState = .searchingLocationBy(city: viewModel.searchText)
            }
        }
        .accessibilityLabel(Text("Home page"))
    }
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
    }
}

#if DEBUG
import NetworkingTestUtilities
import RestAPI
import RestAPITestUtilities
#endif
#Preview(traits: .sizeThatFitsLayout) {
    let mockDataLoader = MockDataLoader()
    mockDataLoader.dataToReturn = provideMockWeatherData()
    let vm = SearchViewModelImpl(
        ConcreteRestAPIService()
            .provideRestAPI(mockDataLoader)
    )
    vm.appState = .locationDetails(
        model: provideMockWeatherModel(),
        city: "Manhattan"
    )
    return HomePage(viewModel: vm)
}
