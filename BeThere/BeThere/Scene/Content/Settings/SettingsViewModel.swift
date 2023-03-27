import BaseKit
import Combine

public final class SettingsViewModel: ObservableObject {
    private var navigator: Navigator<ContentSceneFactory>
    private var userDataService: UserDataServiceInput
    private var cancellables = Set<AnyCancellable>()

    private var nameMemento: String = .empty
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
        if nameMemento != name, name.count > 2 {
            userDataService.updateUserName(to: name)
        } else {
            // TODO: show error message
        }

        if let image = image {
            userDataService.upload(image: image)
        } else {
            // TODO: show error message
        }
    }
}

private extension SettingsViewModel {
    func registerUserBinding() {
        userDataService.user
            .sink { [weak self] in
                if let user = $0 {
                    self?.name = user.name
                    self?.nameMemento = user.name
                }
            }
            .store(in: &cancellables)
    }
}
