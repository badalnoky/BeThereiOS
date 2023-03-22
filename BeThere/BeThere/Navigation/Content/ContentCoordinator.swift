import BaseKit

public final class ContentCoordinator: Coordinator<ContentSceneFactory> {}

public extension Navigator where Factory == ContentSceneFactory {
    func showSettings() {
        push(screen: .settings)
    }

    func showSearch() {
        push(screen: .search)
    }

    func showChat() {
        push(screen: .chat)
    }

    func showEvent(for id: String = .empty) {
        push(screen: .event(id))
    }

    func showAddMember() {
        push(screen: .addMember)
    }
}
