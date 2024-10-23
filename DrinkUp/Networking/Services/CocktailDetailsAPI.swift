import Foundation
import Alamofire

final class CocktailDetailsAPI: CocktailDetailsService {
    
    private var session: Session {
        NetworkManager.shared
    }
    
    func getDetails(id: String) async throws -> CocktailDetails {
        let url = try CocktailDetailsEndpoint.details(id).createURL()
        do {
            let list = try await session.request(url).serializingDecodable(ListContainer<CocktailDetails>.self).value.drinks
            guard let details = list.first else { throw APIError.notFound }
            return details
        } catch {
            if error.asAFError?.isResponseSerializationError == true {
                throw APIError.notFound
            } else {
                throw APIError.requestError(error)
            }
        }
    }
}
