import SwiftUI

@main
struct BeThereApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var coordinator = AppCoordinator(
        authenticationCoordinator: AuthenticationCoordinator(root: .login),
        contentCoordinator: ContentCoordinator(root: .main)
    )

    var body: some Scene {
        WindowGroup {
            coordinator.view(for: coordinator.activeFlow)
        }
    }
}
