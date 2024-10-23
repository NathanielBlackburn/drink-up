import Foundation

final class MockCocktailsAPI: CocktailsService {

    func search(byName name: String) async throws -> [Cocktail] {
        Cocktail.createMocks().filter {
            $0.name.lowercased().contains(name.lowercased().trimmingCharacters(in: .whitespaces))
        }
    }

    func search(byIngredient: String) async throws -> [Cocktail] {
        let cocktails = Cocktail.createMocks()
        return switch byIngredient.lowercased().trimmingCharacters(in: .whitespaces) {
        case "vodka":
            [cocktails[2], cocktails[4]]
        case "rum":
            [cocktails[3]]
        case "orange":
            [cocktails[1]]
        case "tequila":
            [cocktails[0]]
        default:
            []
        }
    }
}
