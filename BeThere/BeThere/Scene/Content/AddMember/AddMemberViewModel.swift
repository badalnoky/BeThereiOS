import BaseKit
import Combine

public final class AddMemberViewModel: ObservableObject {
    private var navigator: Navigator<ContentSceneFactory>
    private var userDataService: UserDataServiceInput
    private var eventService: EventDataServiceInput
    private var cancellables = Set<AnyCancellable>()

    private var eventId: String

    @Published var friends: [User] = []
    @Published var otherUsers: [User] = []
    @Published var searchString: String = .empty {
        didSet {
            if !searchString.isEmpty {
                userDataService.fetchSearchedUsers(containing: searchString, isInitialFetch: false, filtering: eventService.provisionalMembers.value)
            } else {
                otherUsers.removeAll()
            }
        }
    }

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
    func didTapAdd(user: User) {
        eventService.provisionallyAdd(user: user)
        userDataService.fetchSearchedUsers(containing: searchString, isInitialFetch: false, filtering: eventService.provisionalMembers.value + [user])
    }
}

private extension AddMemberViewModel {
    func registerBindings() {
        registerFriendBinding()
        registerOtherUserBinding()
    }

    func registerFriendBinding() {
        userDataService.fetchSearchedUsers(containing: .empty, isInitialFetch: true, filtering: eventService.provisionalMembers.value)
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
