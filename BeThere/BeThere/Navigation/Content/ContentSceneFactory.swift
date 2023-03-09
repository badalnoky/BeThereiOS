import BaseKit
import SwiftUI

public final class ContentSceneFactory: SceneFactory {
    public init() {}

    @ViewBuilder
    public func view(for screen: ContentScreen, with navigator: Navigator<ContentSceneFactory>) -> some View {
        switch screen {
        case .main: main(with: navigator)
        case .settings: SettingsView()
        case .search: SearchView()
        case .chat: ChatView()
        case .event: EventView()
        }
    }
}

extension ContentSceneFactory {
    func main(with navigator: Navigator<ContentSceneFactory>) -> MainView {
        MainView(viewModel: MainViewModel(navigator: navigator))
    }
}
