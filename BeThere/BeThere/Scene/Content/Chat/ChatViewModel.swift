import BaseKit

final class ChatViewModel: ObservableObject {
    private var navigator: Navigator<ContentSceneFactory>

    var eventId: String = "this is the id of an event"
    var event: String = .empty
    var date: Date = .now
    var location: String = .empty
    @Published var messages: [String] = ["these", "are", "the", "group", "messages"]
    @Published var currentMessage: String = .empty

    init(navigator: Navigator<ContentSceneFactory>) {
        self.navigator = navigator
    }
}

extension ChatViewModel {
    func didTapEdit() {
        navigator.showEvent(for: eventId)
    }
}
