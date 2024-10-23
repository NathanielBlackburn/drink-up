import SwiftUI
import Factory
import Kingfisher

struct CocktailDetailsView: View {

    @State private var vm = CocktailDetailsViewModel()
    
    private let id: String
    private let name: String
    
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            VStack {
                detailsView
                    .padding(.bottom, UI.Spacing.standard)
                    .display(if: vm.details != nil)

                emptyStateViews
            }
        }
        .navigationBarTitle(name, displayMode: .large)
        .onAppear {
            vm.id = id
            Task {
                await vm.fetch()
            }
        }
    }

    @ViewBuilder var emptyStateViews: some View {
        if let error = vm.error {
            RequestErrorView(error: error) {
                Task {
                    await vm.fetch()
                }
            }
        } else if vm.details == nil {
            DetailsLoadingView()
        }
    }
    
    var detailsView: some View {
        HStack(alignment: .top) {
            VStack {
                ScrollView {
                    Unwrap(vm.details) { details in
                        imageView(details: details)

                        detailsView(details: details)
                    }
                }
            }
            .containerRelativeFrame(.horizontal) { size, _ in
                size * 0.8
            }
            .padding(UI.Spacing.standard)
        }
        .background(Color.detailsBg)
        .cornerRadius(UI.CornerRadius.medium)
    }
    
    func imageView(details: CocktailDetails) -> some View {
        ZStack(alignment: .bottomLeading) {
            KFImage(details.thumbnail)
                .placeholder {
                    ProgressView()
                        .progressViewStyle(.circular)
                }
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: UI.CornerRadius.large))
            
            ZStack {
                Circle()
                    .foregroundColor(.black)
                    .frame(width: 25, height: 25)
                    .opacity(0.5)
                Image.nonAlcoholic
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 22, height: 22)
                    .foregroundColor(.white)
                    .padding(UI.Spacing.standard)
            }
            .display(if: details.isNonAlcoholic)
        }
    }
    
    func detailsView(details: CocktailDetails) -> some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: UI.Spacing.standard) {
                VStack(alignment: .leading) {
                    Text("Category")
                        .font(.headline)
                    Text(details.category)
                        .font(.callout)
                }
                if !details.ingredients.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Ingredients")
                            .font(.headline)
                        ForEach(details.ingredients, id: \.name) {
                            Text($0.name + " ")
                                .font(.callout)
                            + Text($0.measure ?? "")
                                .font(.caption2)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Glass")
                        .font(.headline)
                    Text(details.glass)
                        .font(.callout)
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .foregroundColor(.black)
        .padding(.top, UI.Spacing.standard)
    }
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}

#Preview("en") {
    let cocktail = CocktailDetails.createMock(whiteBackground: true)
    let _ = Container.shared.cocktailDetailsService.register { MockCocktailDetailsAPI(model: cocktail) }
    CocktailDetailsView(id: cocktail.id, name: cocktail.name)
}

#Preview("pl") {
    let cocktail = CocktailDetails.createMock(whiteBackground: true)
    let _ = Container.shared.cocktailDetailsService.register { MockCocktailDetailsAPI(model: cocktail) }
    CocktailDetailsView(id: cocktail.id, name: cocktail.name)
        .environment(\.locale, .init(identifier: "pl"))
}
