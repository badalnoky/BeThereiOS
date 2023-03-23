import BaseKit
import Resolver
import SwiftUI

public final class ContentSceneFactory: SceneFactory {
    public init() {}

    @ViewBuilder
    public func view(for screen: ContentScreen, with navigator: Navigator<ContentSceneFactory>) -> some View {
        switch screen {
        case .main: main(with: navigator)
        case .settings: settings(with: navigator)
        case .search: search(with: navigator)
        case .chat(let eventId): chat(with: navigator, eventId: eventId)
        case .event(let eventId): event(with: navigator, eventId: eventId)
        case .addMember: addMember(with: navigator)
        }
    }
}

extension ContentSceneFactory {
    func main(with navigator: Navigator<ContentSceneFactory>) -> MainView {
        MainView(
            viewModel: MainViewModel(
                navigator: navigator,
                authenticationService: Resolver.resolve(),
                userDataService: Resolver.resolve(),
                eventService: Resolver.resolve()
            )
        )
    }

    func settings(with navigator: Navigator<ContentSceneFactory>) -> SettingsView {
        SettingsView(
            viewModel: SettingsViewModel(
                navigator: navigator,
                userDataService: Resolver.resolve()
            )
        )
    }

    func search(with navigator: Navigator<ContentSceneFactory>) -> SearchView {
        SearchView(
            viewModel: SearchViewModel(
                navigator: navigator,
                userDataService: Resolver.resolve()
            )
        )
    }

    func chat(with navigator: Navigator<ContentSceneFactory>, eventId: String) -> ChatView {
        ChatView(viewModel: ChatViewModel(navigator: navigator, eventId: eventId))
    }

    func event(with navigator: Navigator<ContentSceneFactory>, eventId: String) -> EventView {
        if eventId.isEmpty {
            return EventView(
                viewModel: EventViewModel(
                    navigator: navigator,
                    evetService: Resolver.resolve(),
                    userDataService: Resolver.resolve()
                )
            )
        } else {
            return EventView(
                viewModel: EventViewModel(
                    navigator: navigator,
                    evetService: Resolver.resolve(),
                    userDataService: Resolver.resolve(),
                    eventId: eventId)
            )
        }
    }

    func addMember(with navigator: Navigator<ContentSceneFactory>) -> AddMemberView {
        AddMemberView(viewModel: AddMemberViewModel(navigator: navigator))
    }
}
