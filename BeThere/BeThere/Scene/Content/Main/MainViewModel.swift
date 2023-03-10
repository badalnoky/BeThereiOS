import BaseKit

final class MainViewModel: ObservableObject {
    private var navigator: Navigator<ContentSceneFactory>

    @Published var searchString: String = .empty
    @Published var events: [String] = ["this", "is", "a", "list"]

    init(navigator: Navigator<ContentSceneFactory>) {
        self.navigator = navigator
    }
}
