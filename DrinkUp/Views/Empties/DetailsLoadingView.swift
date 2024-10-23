import SwiftUI

struct DetailsLoadingView: View {

    var body: some View {
        ProgressView("Loading, please wait...")
            .font(.system(.title2))
    }
}

#Preview("en") {
    DetailsLoadingView()
}

#Preview("pl") {
    DetailsLoadingView()
        .environment(\.locale, .init(identifier: "pl"))
}
