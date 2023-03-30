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

    func mainNavigationBar(
        signOutAction: @escaping () -> Void,
        searchAction: @escaping () -> Void,
        settingsAction: @escaping () -> Void
    ) -> some View {
        modifier(
            MainNavigationBarModifier(
                signOutAction: signOutAction,
                searchAction: searchAction,
                settingsAction: settingsAction
            )
        )
    }

    func eventNavigationBar(title: String, editAction: @escaping () -> Void) -> some View {
        modifier(EventNavigationBarModifier(title: title, editAction: editAction))
    }
}
