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
    @Published var alertText: String = .empty
    @Published var displayAlert = false

    public var submitDisabled: Bool {
        (nameMemento == name || name.count < 3) && !hasImageChanged
    }

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
        }

        if let uiImage = image, hasImageChanged {
            userDataService.upload(image: uiImage)
                .sink { [weak self] success in
                    self?.hasImageChanged = false
                    self?.handleMessage(.successfulUpload)
                } receiveError: { _ in self.handleMessage(.uploadError) }
                .store(in: &cancellables)
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

    func handleMessage(_ message: SettingsMessage) {
        alertText = message.description
        displayAlert = true
    }
}
