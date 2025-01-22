import SwiftUI

struct SearchContentUnavailableView: View {
    private let placeholder: LocalizedStringKey = "No City Selected"
    private let description: LocalizedStringKey = "Please Search For A City"
    var body: some View {
        ContentUnavailableView {
            Text(placeholder)
                .font(.system(size: 30, weight: .semibold))
                .foregroundStyle(Color(red: 44/255, green: 44/255, blue: 44/255))
                .accessibilityLabel(Text(placeholder))
        } description: {
            Text(description)
                .font(.subheadline)
                .foregroundColor(Color(red: 44/255, green: 44/255, blue: 44/255))
                .padding(.top, 8)
                .accessibilityLabel(Text(description))
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    SearchContentUnavailableView()
}
