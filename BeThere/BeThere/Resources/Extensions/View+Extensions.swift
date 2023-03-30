import SwiftUI

extension View {
    func textStyle(_ style: TextStyle) -> some View {
        self
            .font(style.font)
            .foregroundColor(style.color)
    }
}
