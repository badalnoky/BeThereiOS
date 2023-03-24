import BaseKit
import Combine

public final class AddMemberViewModel: ObservableObject {
    private var navigator: Navigator<ContentSceneFactory>
    private var userDataService: UserDataServiceInput
    private var eventService: EventDataServiceInput
    private var cancellables = Set<AnyCancellable>()

    private var eventId: String

    @Published var searchString: String = .empty
    @Published var friends: [User] = []
    @Published var otherUsers: [User] = []

    init(
        navigator: Navigator<ContentSceneFactory>,
        userDataService: UserDataServiceInput,
        eventService: EventDataServiceInput,
        eventId: String
    ) {
        self.navigator = navigator
        self.userDataService = userDataService
        self.eventService = eventService
        self.eventId = eventId

        registerBindings()
    }
}

extension AddMemberViewModel {
    func didTapSearch() {
        if searchString.count > 2 {
            userDataService.fetchSearchedUsers(containing: searchString, isInitialFetch: false)
        } else {
            // TODO: show error message
        }
    }
    func didTapAdd(user: User) {
        // add members to list
    }
}

private extension AddMemberViewModel {
    func registerBindings() {
        registerFriendBinding()
        registerOtherUserBinding()
    }

    func registerFriendBinding() {
        userDataService.fetchSearchedUsers(containing: .empty, isInitialFetch: true)
        userDataService.searchedFriendMembers
            .sink { [weak self] users in
                self?.friends = users
            }
            .store(in: &cancellables)
    }

    func registerOtherUserBinding() {
        userDataService.searchedOtherMembers
            .sink { [weak self] users in
                self?.otherUsers = users
            }
            .store(in: &cancellables)
    }
}
