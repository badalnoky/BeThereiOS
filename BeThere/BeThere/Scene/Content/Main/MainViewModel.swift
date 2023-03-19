import BaseKit
import Combine

final class MainViewModel: ObservableObject {
    private var navigator: Navigator<ContentSceneFactory>
    private var authenticationService: AuthenticationServiceInput
    private var dataService: DataServiceInput
    private var cancellables = Set<AnyCancellable>()

    @Published var searchString: String = .empty
    @Published var events: [String] = ["this", "is", "a", "list"]

    init(
        navigator: Navigator<ContentSceneFactory>,
        authenticationService: AuthenticationServiceInput,
        dataService: DataServiceInput
    ) {
        self.navigator = navigator
        self.authenticationService = authenticationService
        self.dataService = dataService

        registerUserBinding()
    }
}

extension MainViewModel {
    func didTapSignOut() {
        authenticationService.signOut()
            .sink(
                receiveValue: { [weak self] in if $0 { self?.navigator.finishFlow() } },
                receiveError: { print($0) }
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

private extension MainViewModel {
    func registerUserBinding() {
        dataService.user
            .sink { [weak self] in
                if let user = $0 { self?.events = user.events }
            }
            .store(in: &cancellables)
    }
}
