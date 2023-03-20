import BaseKit
import Combine

public final class SearchViewModel: ObservableObject {
    private var navigator: Navigator<ContentSceneFactory>
    private var dataService: DataServiceInput
    private var cancellables = Set<AnyCancellable>()
    private var isInEventCreation: Bool

    @Published var searchString: String = .empty
    @Published var friends: [User] = []
    @Published var otherUsers: [User] = []

    init(
        navigator: Navigator<ContentSceneFactory>,
        dataService: DataServiceInput,
        isInEventCreation: Bool = false
    ) {
        self.navigator = navigator
        self.dataService = dataService
        self.isInEventCreation = isInEventCreation

        registerBindings()
    }
}

extension SearchViewModel {
    func didTapSearch() {
        if searchString.count > 2 {
            dataService.fetchUsers(containing: searchString, isFetchingFriends: false)
            if isInEventCreation { dataService.fetchUsers(containing: searchString, isFetchingFriends: true) }
        } else {
            // TODO: show error message
        }
    }
}

private extension SearchViewModel {
    func registerBindings() {
        registerOtherUsersBinding()
        if isInEventCreation {
            registerFriendsBinding()
        }
    }

    func registerOtherUsersBinding() {
        dataService.foundUsers
            .sink { [weak self] users in
                self?.otherUsers = users
            }
            .store(in: &cancellables)
    }

    func registerFriendsBinding() {
        dataService.filteredFriends
            .sink { [weak self] users in
                self?.friends = users
            }
            .store(in: &cancellables)
    }
}
