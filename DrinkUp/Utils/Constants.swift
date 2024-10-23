// swiftlint:disable:this file_name
// swiftlint:disable type_name
import Foundation

enum UI {

    enum Spacing {
        
        static let small: CGFloat = 5
        static let medium: CGFloat = 10
        static let standard: CGFloat = 16
        static let large: CGFloat = 30
        static let listRow: CGFloat = 12
    }
    
    enum CornerRadius {
        
        static let small: CGFloat = 5
        static let medium: CGFloat = 10
        static let large: CGFloat = 16
    }
    
    enum TimeInterval {
        
        static var searchBarDebounceTime: Int {
            isUnitTesting ? 0 : 800
        }
        
        private static var isUnitTesting: Bool {
            UserDefaults.standard.bool(forKey: "isUnitTesting")
        }
    }
}
// swiftlint:enable type_name
