import SwiftUI

public struct Unwrap<T, V: View>: View {

    private let t: T?
    private let content: (T) -> V
    
    public init(_ t: T?, @ViewBuilder content: @escaping (T) -> V) {
        self.t = t
        self.content = content
    }
    
    public var body: some View {
        if let t = t {
            content(t)
        }
    }
}
