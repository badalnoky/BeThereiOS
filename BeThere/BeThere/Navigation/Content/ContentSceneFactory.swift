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
        case .chat: chat(with: navigator)
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
                dataService: Resolver.resolve(),
                eventService: Resolver.resolve()
            )
        )
    }

    func settings(with navigator: Navigator<ContentSceneFactory>) -> SettingsView {
        SettingsView(
            viewModel: SettingsViewModel(
                navigator: navigator,
                dataService: Resolver.resolve()
            )
        )
    }

    func search(with navigator: Navigator<ContentSceneFactory>) -> SearchView {
        SearchView(
            viewModel: SearchViewModel(
                navigator: navigator,
                dataService: Resolver.resolve()
            )
        )
    }

    func chat(with navigator: Navigator<ContentSceneFactory>) -> ChatView {
        ChatView(viewModel: ChatViewModel(navigator: navigator))
    }

    func event(with navigator: Navigator<ContentSceneFactory>, eventId: String) -> EventView {
        if eventId.isEmpty {
            return EventView(viewModel: EventViewModel(navigator: navigator, evetService: Resolver.resolve()))
        } else {
            return EventView(viewModel: EventViewModel(navigator: navigator, evetService: Resolver.resolve(), eventId: eventId))
        }
    }

    func addMember(with navigator: Navigator<ContentSceneFactory>) -> AddMemberView {
        AddMemberView(viewModel: AddMemberViewModel(navigator: navigator))
    }
}
