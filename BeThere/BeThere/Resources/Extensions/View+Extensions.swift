import SwiftUI

extension View {
    func textFieldOverlay(isFocused: Bool, isValid: Bool) -> some View {
        self
            .overlay {
                RoundedRectangle(cornerRadius: .cornerRadius)
                    .stroke(
                        isValid ? (isFocused ? Color.appPrimary : Color.appAccentColor) : Color.error,
                        lineWidth: isFocused ? .focusedBorderWidth : .borderWidth
                    )
            }
            .background(
                RoundedRectangle(cornerRadius: .cornerRadius)
                    .fill(Color.appSecondary)
            )
    }

    func textStyle(_ style: TextStyle) -> some View {
        self
            .font(style.font)
            .foregroundColor(style.color)
    }

    func keyboardSettings(for style: StyledFieldStyle) -> some View {
        self
            .keyboardType(style.keyboardType)
            .textContentType(style.textType)
            .autocapitalization(style.capitalizationType)
            .autocorrectionDisabled()
    }

    func styledDivider() -> some View {
        self
            .frame(minHeight: .borderWidth)
            .background(Color.appPrimary)
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
