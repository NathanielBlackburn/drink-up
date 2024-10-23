import SwiftUI

struct RequestErrorView: View {

    private let error: Error
    private let refresh: () -> Void

    var body: some View {
        VStack(alignment: .center, spacing: UI.Spacing.standard) {
            Image.circleX
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundColor(.red)
                .opacity(0.5)
            Text(error.localizedDescription)
                .multilineTextAlignment(.center)
                .padding(.horizontal, UI.Spacing.large)
            Button("Try again") {
                refresh()
            }
        }
    }

    init(error: Error, refresh: @escaping () -> Void) {
        self.error = error
        self.refresh = refresh
    }
}

#Preview("en") {
    RequestErrorView(error: APIError.malformedURL, refresh: {})
}

#Preview("pl") {
    RequestErrorView(error: APIError.malformedURL, refresh: {})
        .environment(\.locale, .init(identifier: "pl"))
}
