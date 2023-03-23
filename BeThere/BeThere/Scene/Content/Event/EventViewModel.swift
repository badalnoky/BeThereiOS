import BaseKit
import Combine

final class EventViewModel: ObservableObject {
    private var navigator: Navigator<ContentSceneFactory>
    private var eventService: EventDataServiceInput
    private var userDataService: UserDataServiceInput
    private var cancellables = Set<AnyCancellable>()
    private var state: EventState
    private var eventId: String

    @Published var name: String = .empty
    @Published var date: Date = .now
    @Published var location: String = .empty
    @Published var members: [User] = []
    @Published var isChoosingDate = false

    init(
        navigator: Navigator<ContentSceneFactory>,
        evetService: EventDataServiceInput,
        userDataService: UserDataServiceInput
    ) {
        self.navigator = navigator
        self.eventService = evetService
        self.userDataService = userDataService
        self.state = .creation
        self.eventId = UUID().uuidString

        registerUserBinding()
    }

    init(
        navigator: Navigator<ContentSceneFactory>,
        evetService: EventDataServiceInput,
        userDataService: UserDataServiceInput,
        eventId: String
    ) {
        self.navigator = navigator
        self.eventService = evetService
        self.userDataService = userDataService
        self.state = .modification
        self.eventId = eventId

        registerUserBinding()
        registerEventBinding()
    }
}

extension EventViewModel {
    func didTapAddFriends() {
        navigator.showAddMember()
    }

    func didTapSave() {
        if name.count > 3, location.count > 3 {
            if state == .creation {
                createEvent()
            } else {
                modifyEvent()
            }
        } else {
            // TODO: handle non compliant field values
        }
    }
}

// MARK: Common
private extension EventViewModel {
    func registerUserBinding() {
        userDataService.user
            .sink { [weak self] in
                if let user = $0, let added = self?.members.contains(where: { $0.id == user.id }), !added {
                    self?.members.append(user)
                }
            }
            .store(in: &cancellables)
    }
}

// MARK: Creation
private extension EventViewModel {
    func createEvent() {
        let users = members.map { $0.id }
        eventService.createEvent(Event(id: eventId, name: name, location: location, date: date, users: users, messages: []))
    }
}

// MARK: Modification
private extension EventViewModel {
    func modifyEvent() {}
    func registerEventBinding() {}
}
