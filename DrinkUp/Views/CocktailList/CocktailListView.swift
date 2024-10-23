import SwiftUI
import Factory

struct CocktailListView: View {

    @StateObject private var vm = CocktailListViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                Color.appBackground.ignoresSafeArea()
                VStack {
                    searchBar
                    
                    toggles

                    if !vm.cocktails.isEmpty {
                        list
                    } else {
                        emptyStateViews
                    }
                    
                    Spacer()
                }
                .padding()
            }
        }
    }

    var searchBar: some View {
        HStack {
            ZStack {
                input
                inputUtils
            }
            .padding(.bottom, UI.Spacing.standard)
        }
    }
    
    var input: some View {
        TextField(
            "",
            text: $vm.searchText,
            prompt: Text("Enter \(vm.searchHint)")
                .foregroundColor(Color.searchBarHint)
        )
            .frame(height: 30)
            .padding(.leading, UI.Spacing.medium)
            .padding(.trailing, UI.Spacing.large)
            .background(Color.searchBarBg)
            .clipped()
            .cornerRadius(UI.CornerRadius.small)
            .autocapitalization(.none)
            .autocorrectionDisabled(true)
    }
    
    @ViewBuilder var inputUtils: some View {
        Button {
            vm.clearSearch()
        } label: {
            Image.circleX
                .foregroundColor(Color.searchBarX)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.trailing, UI.Spacing.small)
        .display(if: !vm.searchText.isEmpty && !vm.isLoading)

        ProgressView()
            .progressViewStyle(.circular)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing, UI.Spacing.small)
            .hide(if: !vm.isLoading)
    }
    
    var toggles: some View {
        VStack(alignment: .leading) {
            Toggle(isOn: $vm.searchByName) {
                Text("Search by \(vm.searchBy)")
            }
            .tint(Color.toggleTint)

            Toggle(isOn: $vm.showNonAlcoholicOnly) {
                Text("Show non-alcoholic only")
            }
            .tint(Color.toggleTint)
            .display(if: vm.searchByName)
        }
    }
    
    var list: some View {
        List {
            ForEach(vm.filteredCocktails.indices, id: \.self) { index in
                let cocktail = vm.filteredCocktails[index]
                ZStack(alignment: .leading) {
                    CocktailListRow(cocktail: cocktail, isEven: index.isMultiple(of: 2))
                    NavigationLink(destination: CocktailDetailsView(id: cocktail.id, name: cocktail.name)) {
                        EmptyView()
                    }
                    .opacity(0)
                }
                .buttonStyle(PlainButtonStyle())
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
            }
        }
        .listStyle(.plain)
        .listRowSpacing(UI.Spacing.listRow)
        .padding(.top, UI.Spacing.standard)
    }
    
    @ViewBuilder var emptyStateViews: some View {
        if let error = vm.error {
            RequestErrorView(error: error) {
                vm.refetch()
            }
        } else {
            EmptyListView(hasSearched: vm.hasSearched)
        }
    }
}

#Preview("en") {
    let _ = Container.shared.cocktailsService.register { MockCocktailsAPI() }
    CocktailListView()
}

#Preview("pl") {
    let _ = Container.shared.cocktailsService.register { MockCocktailsAPI() }
    CocktailListView()
        .environment(\.locale, .init(identifier: "pl"))
}
