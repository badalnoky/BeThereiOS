import BaseKit

public final class AuthenticationCoordinator: Coordinator<AuthenticationSceneFactory> {}

public extension Navigator where Factory == AuthenticationSceneFactory {
    func showRegistration() {
        push(screen: .registration)
    }
}
