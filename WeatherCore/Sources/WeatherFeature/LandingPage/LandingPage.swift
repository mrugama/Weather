import Networking
import RestAPI
import SwiftUI

@MainActor
public struct LandingPage: Sendable {
    public static var pageView: some View {
        HomePage(
            viewModel: SearchViewModelImpl(
                ConcreteRestAPIService().provideRestAPI(
                    ConcreteDataLoaderService().provideDataLoader()
                )
            )
        )
    }
}
