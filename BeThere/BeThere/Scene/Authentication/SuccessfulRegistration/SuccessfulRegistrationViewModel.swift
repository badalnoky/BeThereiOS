import BaseKit

final class SuccessfulRegistrationViewModel: ObservableObject {
    private var navigator: Navigator<AuthenticationSceneFactory>

    init(navigator: Navigator<AuthenticationSceneFactory>) {
        self.navigator = navigator
    }
}

extension SuccessfulRegistrationViewModel {
    func didTapNext() {
        navigator.finishFlow()
    }
}
