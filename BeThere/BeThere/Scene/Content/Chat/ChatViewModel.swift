import BaseKit
import Combine

final class ChatViewModel: ObservableObject {
    private var navigator: Navigator<ContentSceneFactory>
    private var eventService: EventDataServiceInput
    private var userDataService: UserDataServiceInput
    private var cancellables = Set<AnyCancellable>()

    private var eventId: String
    private var userId: String = .empty

    @Published var event: Event = .mock
    @Published var members: [User] = []
    @Published var currentMessage: String = .empty

    init(
        navigator: Navigator<ContentSceneFactory>,
        evetService: EventDataServiceInput,
        userDataService: UserDataServiceInput,
        eventId: String
    ) {
        self.navigator = navigator
        self.eventService = evetService
        self.userDataService = userDataService
        self.eventId = eventId

        registerBindings()
    }
}

extension ChatViewModel {
    func didTapEdit() {
        navigator.showEvent(for: eventId)
    }

    func didTapSend() {
        if !currentMessage.isEmpty {
            eventService.send(Message(id: UUID().uuidString, sentBy: userId, text: currentMessage), to: eventId)
            currentMessage = .empty
        }
    }
}

private extension ChatViewModel {
    func registerBindings() {
        registerEventBinding()
        registerMembersBinding()
        registerUserBinding()
    }

    func registerEventBinding() {
        eventService.getEventData(for: eventId)
        eventService.currentEvent
            .sink { [weak self] event in
                guard let self = self else { return }
                self.event = event
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

    func registerUserBinding() {
        userDataService.user
            .sink { [weak self] in
                if let user = $0 {
                    self?.userId = user.id
                    print(user.id)
                }
            }
            .store(in: &cancellables)
    }
}
