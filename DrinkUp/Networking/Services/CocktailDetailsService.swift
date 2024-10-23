import Foundation

protocol CocktailDetailsService {

    func getDetails(id: String) async throws -> CocktailDetails
}
