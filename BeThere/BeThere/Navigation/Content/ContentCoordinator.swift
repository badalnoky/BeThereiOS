import BaseKit

public final class ContentCoordinator: Coordinator<ContentSceneFactory> {}

public extension Navigator where Factory == ContentSceneFactory {
    func showSettings() {
        push(screen: .settings)
    }

    func showSearch() {
        push(screen: .search)
    }

    func showChat(for eventId: String) {
        push(screen: .chat(eventId))
    }

    func showEvent(for id: String = .empty) {
        push(screen: .event(id))
    }

    func showAddMember(eventId: String) {
        push(screen: .addMember(eventId))
    }
}
