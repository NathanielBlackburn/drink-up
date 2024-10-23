import Foundation

final class MockCocktailDetailsAPI: CocktailDetailsService {

    private let model: CocktailDetails

    init(model: CocktailDetails? = nil) {
        self.model = model ?? CocktailDetails.createMock()
    }

    func getDetails(id: String) async throws -> CocktailDetails {
        model
    }
}
