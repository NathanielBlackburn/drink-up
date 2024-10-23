import Foundation

protocol CocktailsService {

    func search(byName: String) async throws -> [Cocktail]
    func search(byIngredient: String) async throws -> [Cocktail]
}
