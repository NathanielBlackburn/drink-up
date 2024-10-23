import Foundation

enum CocktailsEndpoint: BaseEndpoint {

    case searchByName(String)
    case searchByIngredient(String)

    var endpointPath: String {
        switch self {
        case .searchByName:
            "search.php"
        case .searchByIngredient:
            "filter.php"
        }
    }

    var queryComponent: (String, String)? {
        switch self {
        case let .searchByName(name):
            ("s", name)
        case let .searchByIngredient(ingredient):
            ("i", ingredient)
        }
    }
}
