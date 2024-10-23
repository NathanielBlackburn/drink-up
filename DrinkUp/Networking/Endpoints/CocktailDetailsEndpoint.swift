import Foundation

enum CocktailDetailsEndpoint: BaseEndpoint {

    case details(String)

    var endpointPath: String {
        switch self {
        case .details:
            "lookup.php"
        }
    }

    var queryComponent: (String, String)? {
        switch self {
        case let .details(id):
            ("i", id)
        }
    }
}
