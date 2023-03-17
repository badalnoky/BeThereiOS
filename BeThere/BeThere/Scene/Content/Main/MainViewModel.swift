import BaseKit
import Combine

final class MainViewModel: ObservableObject {
    private var navigator: Navigator<ContentSceneFactory>
    private var authenticationService: AuthenticationServiceInput
    private var cancellables = Set<AnyCancellable>()

    @Published var searchString: String = .empty
    @Published var events: [String] = ["this", "is", "a", "list"]

    init(
        navigator: Navigator<ContentSceneFactory>,
        authenticationService: AuthenticationServiceInput
    ) {
        self.navigator = navigator
        self.authenticationService = authenticationService
    }
}

extension MainViewModel {
    func didTapSignOut() {
        authenticationService.signOut()
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error): print(error)
                    default: break
                    }
                },
                receiveValue: { [weak self] signedOut in
                    if signedOut {
                        self?.navigator.finishFlow()
                    }
                }
            )
            .store(in: &cancellables)
    }

    func didTapAddFriends() {
        navigator.showSearch()
    }

    func didTapSettings() {
        navigator.showSettings()
    }

    func didTapEvent() {
        navigator.showChat()
    }

    func didTapCreate() {
        navigator.showEvent()
    }
}
