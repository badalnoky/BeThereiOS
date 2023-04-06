import BaseKit
import Combine

final class ChatViewModel: ObservableObject {
    private var navigator: Navigator<ContentSceneFactory>
    private var eventService: EventDataServiceInput
    private var userDataService: UserDataServiceInput
    private var cancellables = Set<AnyCancellable>()

    private var eventId: String
    private var userId: String = .empty

    var urlCatalog: [String: String] = [:]

    @Published var event: Event = .mock
    @Published var members: [User] = []
    @Published var currentMessage: String = .empty

    init(
        navigator: Navigator<ContentSceneFactory>,
        eventService: EventDataServiceInput,
        userDataService: UserDataServiceInput,
        eventId: String
    ) {
        self.navigator = navigator
        self.eventService = eventService
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

    func getMessageSettings(indexed idx: Int) -> MessageSettings {
        let message = event.messages[idx]
        let isNotLast = idx != event.messages.count.previous
        let isContinued = isNotLast && (message.sentBy == event.messages[idx.next].sentBy)
        let sentByUser = message.sentBy == userId

        return MessageSettings(sentByUser: sentByUser, isContinued: isContinued)
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
                for user in users {
                    self.urlCatalog[user.id] = user.photo
                }
            }
            .store(in: &cancellables)
    }

    func registerUserBinding() {
        userDataService.user
            .sink { [weak self] in
                if let user = $0 {
                    self?.userId = user.id
                }
            }
            .store(in: &cancellables)
    }
}
