import Networking
import RestAPI
import SwiftUI

@MainActor
public struct LandingPage: Sendable {
    public static var pageView: some View {
        lazy var dataLoader: DataLoader = ConcreteDataLoaderService().provideDataLoader()
        lazy var restAPI: RestAPI = ConcreteRestAPIService().provideRestAPI(dataLoader)
        return HomePage(viewModel: SearchViewModelImpl(restAPI))
    }
}
