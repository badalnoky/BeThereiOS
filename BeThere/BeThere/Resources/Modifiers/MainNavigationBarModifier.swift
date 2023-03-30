import SwiftUI

public struct MainNavigationBarModifier: ViewModifier {
    let signOutAction: () -> Void
    let searchAction: () -> Void
    let settingsAction: () -> Void

    public func body(content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) { signOutButton }
                ToolbarItem(placement: .navigationBarTrailing) { searchButton }
                ToolbarItem(placement: .navigationBarTrailing) { settingsButton }
            }
    }
}

extension MainNavigationBarModifier {
    @ViewBuilder var signOutButton: some View {
        Button(action: signOutAction) {
            Image.signOut
                .fittedToSize(.defaultIconSize)
        }
    }

    @ViewBuilder var searchButton: some View {
        Button(action: searchAction) {
            Image.addFriends
                .fittedToSize(.defaultIconSize)
        }
    }

    @ViewBuilder var settingsButton: some View {
        Button(action: settingsAction) {
            Image.settings
                .fittedToSize(.defaultIconSize)
        }
    }
}
