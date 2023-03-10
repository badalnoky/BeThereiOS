import BaseKit

final class SettingsViewModel: ObservableObject {
    private var navigator: Navigator<ContentSceneFactory>

    @Published var name: String = .empty

    init(navigator: Navigator<ContentSceneFactory>) {
        self.navigator = navigator
    }
}
