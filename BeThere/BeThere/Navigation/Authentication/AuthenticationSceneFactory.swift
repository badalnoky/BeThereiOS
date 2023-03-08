import BaseKit
import SwiftUI

public final class AuthenticationSceneFactory: SceneFactory {
    public init() {}

    @ViewBuilder
    public func view(for screen: AuthenticationScreen, with navigator: Navigator<AuthenticationSceneFactory>) -> some View {
        switch screen {
        case .login: login(with: navigator)
        case .registration: registration(with: navigator)
        case .succesfulRegistration: SuccesfulRegistrationView()
        }
    }
}

extension AuthenticationSceneFactory {
    func login(with navigator: Navigator<AuthenticationSceneFactory>) -> LoginView {
        LoginView(viewModel: LoginViewModel(navigator: navigator))
    }

    func registration(with navigator: Navigator<AuthenticationSceneFactory>) -> RegistrationView {
        RegistrationView(viewModel: RegistrationViewModel(navigator: navigator))
    }
}
