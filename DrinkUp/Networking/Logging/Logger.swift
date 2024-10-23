import Foundation
import Alamofire

final class Logger: EventMonitor {

    enum Level: Int, Comparable {

        case error, warning, info, debug

        static func < (lhs: Logger.Level, rhs: Logger.Level) -> Bool {
            lhs.rawValue < rhs.rawValue
        }
    }
    
    let queue = DispatchQueue(label: "drinkUpAlamofireLogger")

    private let level: Level
    
    init(level: Level = .error) {
        self.level = level
    }

    func requestDidResume(_ request: Request) {
        if level > .warning {
            debugPrint("Resuming: \(request)")
        }
    }

    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        if level >= .debug,
           let data = response.data,
           let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            print("JSON response:")
            print(String(decoding: jsonData, as: UTF8.self))
        }
        switch response.result {
        case .success(let data):
            if level >= .info {
                debugPrint(data)
            }
        case .failure(let error):
            if level == .error {
                debugPrint(error)
            }
        }
    }
}
