import BaseKit
import Combine

final class EventViewModel: ObservableObject {
    private var navigator: Navigator<ContentSceneFactory>
    private var eventService: EventDataServiceInput
    private var userDataService: UserDataServiceInput
    private var cancellables = Set<AnyCancellable>()

    private var state: EventState
    private var eventId: String
    private var memento: Event = .mock

    @Published var name: String = .empty
    @Published var date: Date = .now
    @Published var location: String = .empty
    @Published var members: [User] = []
    @Published var isChoosingDate = false

    init(
        navigator: Navigator<ContentSceneFactory>,
        eventService: EventDataServiceInput,
        userDataService: UserDataServiceInput
    ) {
        self.navigator = navigator
        self.eventService = eventService
        self.userDataService = userDataService
        self.state = .creation
        self.eventId = UUID().uuidString

        registerUserBinding()
        registerProvisionalUsersBinding()
    }

    init(
        navigator: Navigator<ContentSceneFactory>,
        eventService: EventDataServiceInput,
        userDataService: UserDataServiceInput,
        eventId: String
    ) {
        self.navigator = navigator
        self.eventService = eventService
        self.userDataService = userDataService
        self.state = .modification
        self.eventId = eventId

        registerModificiationBindings()
        registerProvisionalUsersBinding()
    }
}

extension EventViewModel {
    func didTapAddFriends() {
        navigator.showAddMember(eventId: eventId)
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

    func setChoosingDate() {
        isChoosingDate = true
    }
}

// MARK: Common
private extension EventViewModel {
    func registerProvisionalUsersBinding() {
        eventService.provisionalMembers
            .sink { [weak self] users in
                guard let self = self else { return }
                let filtered = users.filter { user in !self.members.contains { $0.id == user.id } }
                self.members.append(contentsOf: filtered)
            }
            .store(in: &cancellables)
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
                self.memento = Event(
                    id: self.eventId,
                    name: event.name,
                    location: event.location,
                    date: event.date,
                    users: event.users,
                    messages: []
                )
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

    func modifyEvent() {
        let users = members.map { $0.id }
        let newEvent = Event(id: eventId, name: name, location: location, date: date, users: users, messages: [])
        eventService.updateEvent(with: eventId, difference: memento.getDifference(from: newEvent))
            .sink { [weak self] in
                if $0 { self?.memento = newEvent}
            }
            .store(in: &cancellables)
    }
}
