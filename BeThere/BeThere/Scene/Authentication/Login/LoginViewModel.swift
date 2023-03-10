import BaseKit

final class LoginViewModel: ObservableObject {
    private var navigator: Navigator<AuthenticationSceneFactory>

    @Published var email: String = .empty
    @Published var password: String = .empty

    init(navigator: Navigator<AuthenticationSceneFactory>) {
        self.navigator = navigator
    }
}
