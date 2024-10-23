import SwiftUI
import Kingfisher

struct CocktailListRow: View {

    private let cocktail: Cocktail
    private let isEven: Bool

    var body: some View {
        HStack {
            KFImage(cocktail.thumbnail)
                .placeholder {
                    ProgressView()
                        .progressViewStyle(.circular)
                }
                .resizable()
                .scaledToFit()
                .containerRelativeFrame(.horizontal) { size, _ in
                    size * 0.3
                }

            VStack(alignment: .leading) {
                Text(cocktail.name)
                    .foregroundColor(Color.listRowText)
                Image.nonAlcoholic
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 22, height: 22)
                    .foregroundColor(Color.listRowText)
                    .display(if: cocktail.isNonAlcoholic)
            }
            .padding(.leading, UI.Spacing.medium)

            Spacer()
        }
        .background(backgroundColor)
        .cornerRadius(UI.CornerRadius.large)
    }
    
    var backgroundColor: Color {
        isEven ? Color.zebraEven : Color.zebraOdd
    }

    init(cocktail: Cocktail, isEven: Bool) {
        self.cocktail = cocktail
        self.isEven = isEven
    }
}

#Preview {
    CocktailListRow(cocktail: Cocktail.createMocks()[0], isEven: true)
    CocktailListRow(cocktail: Cocktail.createMocks()[1], isEven: false)
}
