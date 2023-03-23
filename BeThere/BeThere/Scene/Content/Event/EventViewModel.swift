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

        registerModificiationBindings()
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

// MARK: Creation
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

    func createEvent() {
        let users = members.map { $0.id }
        eventService.createEvent(Event(id: eventId, name: name, location: location, date: date, users: users, messages: []))
        navigator.pop()
    }
}

// MARK: Modification
private extension EventViewModel {
    func registerModificiationBindings() {
        registerEventBinding()
        registerMembersBinding()
    }

    func registerEventBinding() {
        eventService.getEventData(for: eventId)
        eventService.currentEvent
            .sink { [weak self] event in
                guard let self = self else { return }
                self.name = event.name
                self.date = event.date
                self.location = event.location
                self.userDataService.fetchMembers(event.users)
            }
            .store(in: &cancellables)
    }

    func registerMembersBinding() {
        userDataService.eventMembers
            .sink { [weak self] users in
                guard let self = self else { return }
                self.members = users
            }
            .store(in: &cancellables)
    }

    func modifyEvent() {}
}
