import Foundation
import Alamofire

final class CocktailsAPI: CocktailsService {

    private var session: Session {
        NetworkManager.shared
    }
    
    func search(byName name: String) async throws -> [Cocktail] {
        try await search(endpoint: .searchByName(name))
    }

    func search(byIngredient ingredient: String) async throws -> [Cocktail] {
        try await search(endpoint: .searchByIngredient(ingredient))
    }
    
    private func search(endpoint: CocktailsEndpoint) async throws -> [Cocktail] {
        let url = try endpoint.createURL()
        do {
            return try await session.request(url).serializingDecodable(ListContainer<Cocktail>.self).value.drinks
        } catch {
            if error.asAFError?.isResponseSerializationError == true {
                throw APIError.notFound
            } else {
                throw APIError.requestError(error)
            }
        }
    }
}
