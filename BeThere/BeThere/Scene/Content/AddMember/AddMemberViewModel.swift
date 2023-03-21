import BaseKit

public final class AddMemberViewModel: ObservableObject {
    private var navigator: Navigator<ContentSceneFactory>

    @Published var searchString: String = .empty
    @Published var friends: [User] = []
    @Published var otherUsers: [User] = []

    init(navigator: Navigator<ContentSceneFactory>) {
        self.navigator = navigator
    }
}

extension AddMemberViewModel {
    func didTapSearch() {}
}
