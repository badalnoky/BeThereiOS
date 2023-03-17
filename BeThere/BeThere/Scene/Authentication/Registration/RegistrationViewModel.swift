import BaseKit
import Combine

final class RegistrationViewModel: ObservableObject {
    private var navigator: Navigator<AuthenticationSceneFactory>
    private var authenticationService: AuthenticationServiceInput
    private var cancellables = Set<AnyCancellable>()

    @Published var email: String = .empty
    @Published var firstName: String = .empty
    @Published var lastName: String = .empty
    @Published var password: String = .empty
    @Published var passwordAgain: String = .empty

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
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error): print(error)
                    default: break
                    }
                },
                receiveValue: { [weak self] signedIn in
                    if signedIn {
                        self?.navigator.showSuccessfulRegistration()
                    }
                }
            )
            .store(in: &cancellables)
    }
}
