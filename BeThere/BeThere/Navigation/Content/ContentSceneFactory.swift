import BaseKit
import SwiftUI

public final class ContentSceneFactory: SceneFactory {
    public init() {}

    @ViewBuilder
    public func view(for screen: ContentScreen, with navigator: Navigator<ContentSceneFactory>) -> some View {
        switch screen {
        case .main: ContentView(text: "main")
        case .settings: ContentView(text: "setting")
        case .search: ContentView(text: "search")
        case .chat: ContentView(text: "chat")
        case .event: ContentView(text: "event")
        }
    }
}
