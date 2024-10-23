import SwiftUI

struct EmptyListView: View {
    
    private let hasSearched: Bool
    
    var body: some View {
        VStack {
            Image.emptyList
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .containerRelativeFrame(.horizontal) { size, _ in
                    size * 0.2
                }

            if hasSearched {
                Text("Sorry, no items found.")
                Text("Try another search term.")
            } else {
                Text("No items to show.")
                Text("Use the search bar above.")
            }
        }
        .foregroundColor(Color.gray)
        .frame(maxHeight: .infinity)
    }
    
    init(hasSearched: Bool) {
        self.hasSearched = hasSearched
    }
}

#Preview("en") {
    EmptyListView(hasSearched: true)
}

#Preview("pl") {
    EmptyListView(hasSearched: false)
        .environment(\.locale, .init(identifier: "pl"))
}
