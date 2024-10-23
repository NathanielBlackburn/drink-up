import Alamofire

enum NetworkManager {

    static let shared = Session(eventMonitors: [Logger(level: .error)])
}
