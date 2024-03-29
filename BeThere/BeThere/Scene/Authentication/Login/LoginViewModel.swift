import BaseKit
import Combine

final class LoginViewModel: AuthenticationErrorHandler, ObservableObject {
    private var navigator: Navigator<AuthenticationSceneFactory>
    private var authenticationService: AuthenticationServiceInput
    private var cancellables = Set<AnyCancellable>()

    @Published var email: String = .empty
    @Published var password: String = .empty

    init(
        navigator: Navigator<AuthenticationSceneFactory>,
        authenticationService: AuthenticationServiceInput
    ) {
        self.navigator = navigator
        self.authenticationService = authenticationService
    }
}

extension LoginViewModel {
    func didTapRegistrate() {
        navigator.showRegistration()
    }

    func didTapLogin() {
        authenticationService.signIn(email: email, password: password)
            .sink(
                receiveValue: { [weak self] in if $0 { self?.navigator.finishFlow() } },
                receiveError: { [weak self] in self?.handleError($0) }
            )
            .store(in: &cancellables)
    }
}
