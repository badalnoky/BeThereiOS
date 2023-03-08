import BaseKit

final class RegistrationViewModel: ObservableObject {
    private var navigator: Navigator<AuthenticationSceneFactory>

    @Published var email: String = .empty
    @Published var firstName: String = .empty
    @Published var lastName: String = .empty
    @Published var password: String = .empty
    @Published var passwordAgain: String = .empty

    init(navigator: Navigator<AuthenticationSceneFactory>) {
        self.navigator = navigator
    }
}
