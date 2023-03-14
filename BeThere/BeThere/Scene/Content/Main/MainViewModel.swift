import BaseKit

final class MainViewModel: ObservableObject {
    private var navigator: Navigator<ContentSceneFactory>

    @Published var searchString: String = .empty
    @Published var events: [String] = ["this", "is", "a", "list"]

    init(navigator: Navigator<ContentSceneFactory>) {
        self.navigator = navigator
    }
}

extension MainViewModel {
    func didTapSignOut() {
        navigator.finishFlow()
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
