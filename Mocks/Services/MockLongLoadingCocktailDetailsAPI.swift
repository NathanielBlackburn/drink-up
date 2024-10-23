import Foundation

final class MockLongLoadingCocktailDetailsAPI: CocktailDetailsService {

    private let model: CocktailDetails

    init(model: CocktailDetails? = nil) {
        self.model = model ?? CocktailDetails.createMock()
    }

    func getDetails(id: String) async throws -> CocktailDetails {
        try await Task.sleep(nanoseconds: UInt64((7 * pow(10.0, 9))))
        return model
    }
}
