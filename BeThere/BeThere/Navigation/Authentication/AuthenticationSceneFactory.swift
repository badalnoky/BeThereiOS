import BaseKit
import SwiftUI

public final class AuthenticationSceneFactory: SceneFactory {
    public init() {}

    @ViewBuilder
    public func view(for screen: AuthenticationScreen, with navigator: Navigator<AuthenticationSceneFactory>) -> some View {
        switch screen {
        case .login: login(with: navigator)
        case .registration: RegistrationView()
        case .succesfulRegistration: SuccesfulRegistrationView()
        }
    }
}

extension AuthenticationSceneFactory {
    func login(with navigator: Navigator<AuthenticationSceneFactory>) -> LoginView {
        LoginView(viewModel: LoginViewModel(navigator: navigator))
    }
}
