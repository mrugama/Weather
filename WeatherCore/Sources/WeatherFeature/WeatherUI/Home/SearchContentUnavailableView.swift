import SwiftUI

struct SearchContentUnavailableView: View {
    private let placeholder: LocalizedStringKey = "No City Selected"
    private let description: LocalizedStringKey = "Please Search For A City"
    var body: some View {
        ContentUnavailableView {
            Text(placeholder)
                .font(.system(size: 40, weight: .semibold))
        } description: {
            Text(description)
                .font(.headline)
                .foregroundStyle(Color.black)
                .padding(.top, 8)
        }
    }
}

#Preview {
    SearchContentUnavailableView()
}
