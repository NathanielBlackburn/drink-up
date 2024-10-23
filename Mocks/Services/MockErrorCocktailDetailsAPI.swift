import Foundation

final class MockErrorCocktailDetailsAPI: CocktailDetailsService {

    func getDetails(id: String) async throws -> CocktailDetails {
        throw APIError.malformedURL
    }
}
