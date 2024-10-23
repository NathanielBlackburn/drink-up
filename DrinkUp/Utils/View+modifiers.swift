import SwiftUI

extension View {

    @ViewBuilder func display(if condition: Bool) -> some View {
        if condition {
            self
        }
    }

    @ViewBuilder func hide(if condition: Bool) -> some View {
        if condition {
            self.hidden()
        } else {
            self
        }
    }
}
