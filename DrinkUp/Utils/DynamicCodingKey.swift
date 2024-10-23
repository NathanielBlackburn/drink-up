import Foundation

struct DynamicCodingKey: CodingKey {

    var stringValue: String
    var intValue: Int?

    init?(intValue: Int) {
        self.intValue = intValue
        stringValue = "\(intValue)"
    }

    init?(stringValue: String) {
        self.stringValue = stringValue
        intValue = Int(stringValue)
    }
}
