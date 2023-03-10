import BaseKit

final class SearchViewModel: ObservableObject {
    private var navigator: Navigator<ContentSceneFactory>

    @Published var searchString: String = .empty
    @Published var friends: [String] = ["these", "are", "your", "friends"]
    @Published var otherUsers: [String] = ["these", "are", "not"]

    init(navigator: Navigator<ContentSceneFactory>) {
        self.navigator = navigator
    }
}
