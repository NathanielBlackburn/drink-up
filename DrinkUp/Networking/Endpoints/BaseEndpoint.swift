import Foundation

protocol BaseEndpoint {

    var baseURLString: String { get }
    var endpointPath: String { get }
    var queryComponent: (String, String)? { get }

    func createURL() throws -> URL
}

extension BaseEndpoint {

    var baseURLString: String {
        "https://www.thecocktaildb.com/api/json/v1/1/"
    }

    func createURL() throws -> URL {
        guard var url = URL(string: baseURLString) else {
            throw APIError.malformedURL
        }

        url = url.appendingPathComponent(endpointPath)
        if let queryComponent {
            url = url.appending(queryItems: [URLQueryItem(name: queryComponent.0, value: queryComponent.1)])
        }
        
        return url
    }
}
