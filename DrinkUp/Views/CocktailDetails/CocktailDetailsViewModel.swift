import Foundation
import Observation
import Factory

@Observable
final class CocktailDetailsViewModel {

    var id: String?
    var details: CocktailDetails?

    var isLoading = false

    var error: Error?

    @ObservationIgnored
    @Injected(\.cocktailDetailsService) private var service
    
    func fetch() async {
        guard let id else { return }
        isLoading = true
        do {
            details = try await service.getDetails(id: id)
        } catch {
            self.error = error
        }
        isLoading = false
    }
}
