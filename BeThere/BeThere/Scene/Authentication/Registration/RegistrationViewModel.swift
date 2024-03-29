import BaseKit
import Combine

public final class RegistrationViewModel: AuthenticationErrorHandler, ObservableObject {
    private var navigator: Navigator<AuthenticationSceneFactory>
    private var authenticationService: AuthenticationServiceInput
    private var cancellables = Set<AnyCancellable>()

    @Published var email: String = .empty
    @Published var firstName: String = .empty
    @Published var lastName: String = .empty
    @Published var password: String = .empty
    @Published var passwordAgain: String = .empty

    public var submitDisabled: Bool {
        let isEmpty = email.isEmpty || firstName.isEmpty || lastName.isEmpty || password.isEmpty || passwordAgain.isEmpty
        let isStrong = password.isStrong
        let isMatching = password == passwordAgain

        return isEmpty || !isStrong || !isMatching
    }

    private var name: String {"\(firstName) \(lastName)"}

    init(
        navigator: Navigator<AuthenticationSceneFactory>,
        authenticationService: AuthenticationServiceInput
    ) {
        self.navigator = navigator
        self.authenticationService = authenticationService
    }
}

extension RegistrationViewModel {
    func didTapRegistrate() {
        authenticationService.registrate(email: email, password: password, name: name)
            .sink(
                receiveValue: { [weak self] in if $0 { self?.navigator.showSuccessfulRegistration() } },
                receiveError: { [weak self] in self?.handleError($0) }
            )
            .store(in: &cancellables)
    }
}
