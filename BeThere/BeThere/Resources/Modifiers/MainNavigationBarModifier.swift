import SwiftUI

public struct MainNavigationBarModifier: ViewModifier {
    let signOutAction: () -> Void
    let searchAction: () -> Void
    let settingsAction: () -> Void

    init(signOutAction: @escaping () -> Void, searchAction: @escaping () -> Void, settingsAction: @escaping () -> Void) {
        self.signOutAction = signOutAction
        self.searchAction = searchAction
        self.settingsAction = settingsAction

        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = UIColor(.appBackground)
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }

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
        IconButton(.signOut, action: signOutAction)
    }

    @ViewBuilder var searchButton: some View {
        IconButton(.addFriends, action: searchAction)
    }

    @ViewBuilder var settingsButton: some View {
        IconButton(.settings, action: settingsAction)
    }
}
