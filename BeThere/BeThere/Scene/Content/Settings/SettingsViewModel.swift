import BaseKit
import Combine

public final class SettingsViewModel: ObservableObject {
    private var navigator: Navigator<ContentSceneFactory>
    private var dataService: DataServiceInput
    private var cancellables = Set<AnyCancellable>()

    @Published var name: String = .empty

    init(
        navigator: Navigator<ContentSceneFactory>,
        dataService: DataServiceInput
    ) {
        self.navigator = navigator
        self.dataService = dataService

        registerUserBinding()
    }
}

public extension SettingsViewModel {
    func didTapSave() {
        dataService.updateUserName(to: name)
    }
}

private extension SettingsViewModel {
    func registerUserBinding() {
        dataService.user
            .sink { [weak self] in
                if let user = $0 { self?.name = user.name}
            }
            .store(in: &cancellables)
    }
}
