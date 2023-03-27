import BaseKit
import Combine

public final class SettingsViewModel: ObservableObject {
    private var navigator: Navigator<ContentSceneFactory>
    private var userDataService: UserDataServiceInput
    private var cancellables = Set<AnyCancellable>()

    @Published var name: String = .empty

    init(
        navigator: Navigator<ContentSceneFactory>,
        userDataService: UserDataServiceInput
    ) {
        self.navigator = navigator
        self.userDataService = userDataService

        registerUserBinding()
    }
}

public extension SettingsViewModel {
    func didTapSave() {
        userDataService.updateUserName(to: name)
    }
}

private extension SettingsViewModel {
    func registerUserBinding() {
        userDataService.user
            .sink { [weak self] in
                if let user = $0 { self?.name = user.name}
            }
            .store(in: &cancellables)
    }
}
