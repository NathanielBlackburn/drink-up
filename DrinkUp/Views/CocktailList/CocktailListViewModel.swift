import Foundation
import SwiftUI
import Combine
import Factory

@MainActor
final class CocktailListViewModel: ObservableObject {

    @Published var cocktails = [Cocktail]()

    @Published var isLoading = false
    
    @Published var error: Error?
    
    @Published var searchText = ""
    
    @Published var searchByName = false {
        didSet {
            refetch()
        }
    }

    @Published var showNonAlcoholicOnly = false
    
    @Published var hasSearched = false
    
    @Injected(\.cocktailsService) private var service
    
    private var cancellables: Set<AnyCancellable> = []
    
    private var searchTerm = "" {
        didSet {
            refetch()
        }
    }

    var searchBy: String {
        searchByName ? String(localized: "name") : String(localized: "ingredient")
    }
    
    var searchHint: String {
        searchByName ? String(localized: "a name") : String(localized: "an ingredient")
    }

    var filteredCocktails: [Cocktail] {
        if showNonAlcoholicOnly {
            cocktails.filter(\.isNonAlcoholic)
        } else {
            cocktails
        }
    }
    
    init() {
        setUpBindings()
    }
    
    func clearSearch() {
        searchText = ""
    }

    private func setUpBindings() {
        $searchText
            .dropFirst()
            .debounce(for: .milliseconds(UI.TimeInterval.searchBarDebounceTime), scheduler: RunLoop.main)
            .removeDuplicates()
            .map { $0.trimmingCharacters(in: .whitespaces).lowercased() }
            .sink { [weak self] text in
                guard let self else { return }
                searchTerm = text
            }
            .store(in: &cancellables)
    }

    func refetch() {
        Task {
            await fetch(name: searchTerm)
        }
    }

    private func fetch(name: String) async {
        guard !name.isEmpty else {
            cocktails = []
            return
        }

        isLoading = true
        do {
            if searchByName {
                cocktails = try await service.search(byName: name)
            } else {
                cocktails = try await service.search(byIngredient: name)
            }
        } catch APIError.notFound {
            cocktails = []
        } catch {
            self.error = error
        }
        hasSearched = true
        isLoading = false
    }
}
