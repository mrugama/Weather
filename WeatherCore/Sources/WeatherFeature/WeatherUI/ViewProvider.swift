import SwiftUI
import RestAPI

public enum ViewProvider {
    @MainActor public static func weatherPage(
        restAPI: RestAPI
    ) -> some View {
        HomePage(viewModel: SearchViewModelImpl(restAPI))
    }
}

