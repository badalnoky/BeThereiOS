import SwiftUI

extension View {
    func textStyle(_ style: TextStyle) -> some View {
        self
            .font(style.font)
            .foregroundColor(style.color)
    }
}

extension View {
    func defaultNavigationBar(title: String, isNavigatable: Bool = true) -> some View {
        modifier(DefaultNavigationBarModifier(title: title, isNavigatable: isNavigatable))
    }
}
