import BaseKit
import Combine

public final class SearchViewModel: ObservableObject {
    private var navigator: Navigator<ContentSceneFactory>
    private var userDataService: UserDataServiceInput
    private var cancellables = Set<AnyCancellable>()

    @Published var otherUsers: [User] = []
    @Published var searchString: String = .empty {
        didSet {
            if !searchString.isEmpty {
                userDataService.fetchUsers(containing: searchString)
            } else {
                otherUsers.removeAll()
            }
        }
    }

    init(
        navigator: Navigator<ContentSceneFactory>,
        userDataService: UserDataServiceInput
    ) {
        self.navigator = navigator
        self.userDataService = userDataService

        registerBindings()
    }
}

extension SearchViewModel {
    func didTapAdd(friend: User) {
        userDataService.addFriend(friend)
    }
}

private extension SearchViewModel {
    func registerBindings() {
        userDataService.fetchUsers(containing: searchString)
        userDataService.searchedUsers
            .sink { [weak self] users in
                self?.otherUsers = users
            }
            .store(in: &cancellables)
    }
}
