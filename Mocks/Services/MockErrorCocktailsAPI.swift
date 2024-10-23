import Foundation

final class MockErrorCocktailsAPI: CocktailsService {

    func search(byName: String) async throws -> [Cocktail] {
        throw APIError.malformedURL
    }

    func search(byIngredient: String) async throws -> [Cocktail] {
        throw APIError.malformedURL
    }
}
