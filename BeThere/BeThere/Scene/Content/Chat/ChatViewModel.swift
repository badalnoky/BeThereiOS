import BaseKit
import Combine

final class ChatViewModel: ObservableObject {
    private var navigator: Navigator<ContentSceneFactory>
    private var eventService: EventDataServiceInput
    private var userDataService: UserDataServiceInput
    private var cancellables = Set<AnyCancellable>()

    private var eventId: String

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
    }
}

private extension ChatViewModel {
    func registerBindings() {
        registerEventBinding()
        registerMembersBinding()
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
}
