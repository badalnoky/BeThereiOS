import BaseKit

final class EventViewModel: ObservableObject {
    private var navigator: Navigator<ContentSceneFactory>

    var event: String = .empty
    var date: Date = .now
    var location: String = .empty
    @Published var members: [String] = ["these", "people", "are", "invited"]

    init(navigator: Navigator<ContentSceneFactory>) {
        self.navigator = navigator
    }
}

extension EventViewModel {
    func didTapAddFriends() {
        navigator.showAddMember()
    }
}
