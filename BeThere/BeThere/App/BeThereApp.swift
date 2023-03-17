import Resolver
import SwiftUI

@main
struct BeThereApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var coordinator: AppCoordinator = Resolver.resolve()

    var body: some Scene {
        WindowGroup {
            coordinator.view(for: coordinator.activeFlow)
        }
    }
}
