import BaseKit
import Combine
import SwiftUI

public final class SettingsViewModel: ObservableObject {
    private var navigator: Navigator<ContentSceneFactory>
    private var userDataService: UserDataServiceInput
    private var cancellables = Set<AnyCancellable>()

    private var nameMemento: String = .empty

    @Published var urlString: String = .empty
    @Published var name: String = .empty
    @Published var image: UIImage?
    @Published var hasImageChanged = false

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

        if let uiImage = image, hasImageChanged {
            userDataService.upload(image: uiImage)
                .sink { success in
                    // TODO: handle succes
                } receiveError: { error in
                    // TODO: Handle error
                }
                .store(in: &cancellables)
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
                    self?.urlString = user.photo
                }
            }
            .store(in: &cancellables)
    }
}
