import BaseKit
import SwiftUI

public final class AuthenticationSceneFactory: SceneFactory {
    public init() {}

    @ViewBuilder
    public func view(for screen: AuthenticationScreen, with navigator: Navigator<AuthenticationSceneFactory>) -> some View {
        switch screen {
        case .login: LoginView()
        case .registration: RegistrationView()
        case .succesfulRegistration: SuccesfulRegistrationView()
        }
    }
}
