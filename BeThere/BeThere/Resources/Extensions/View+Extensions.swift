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

    func defaultViewSettings() -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.padding16)
            .background(Color.appBackground)
    }

    func messageSettings(_ settings: MessageSettings) -> some View {
        self
            .foregroundColor(settings.sentByUser ? Color.appBackground : Color.appAccentColor)
            .textStyle(.callout)
            .padding(.padding16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: .cornerRadius)
                    .fill(settings.sentByUser ? Color.appPrimary : Color.appSecondary)
            )
            .padding(settings.sentByUser ? .leading : .trailing, .messagePadding)
            .padding(.bottom, settings.isContinued ? .padding4 : .padding16)
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
