import BaseKit
import Combine

final class LoginViewModel: ObservableObject {
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
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error): print(error)
                    default: break
                    }
                },
                receiveValue: { [weak self] signedIn in
                    if signedIn {
                        self?.navigator.finishFlow()
                    }
                }
            )
            .store(in: &cancellables)
    }
}
