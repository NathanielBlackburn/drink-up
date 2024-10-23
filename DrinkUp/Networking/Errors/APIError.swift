import Foundation

enum APIError: LocalizedError, Equatable {

    case malformedURL
    case notFound
    case requestError(Error)

    static func == (lhs: APIError, rhs: APIError) -> Bool {
        switch (lhs, rhs) {
        case (.malformedURL, .malformedURL):
            return true
        case (.notFound, .notFound):
            return true
        case (.requestError, .requestError):
            return true
        default:
            return false
        }
    }

    var errorDescription: String? {
        switch self {
        case .malformedURL:
            return String(localized: "Malformed URL, cannot process your request.")
        case .notFound:
            return String(localized: "Not found")
        case .requestError:
            return String(localized: "There was a problem processing your request. Please check your Internet connection.")
        }
    }
}
