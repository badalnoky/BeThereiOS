import BaseKit
import SwiftUI

public final class AuthenticationSceneFactory: SceneFactory {
    public init() {}

    @ViewBuilder
    public func view(for screen: AuthenticationScreen, with navigator: Navigator<AuthenticationSceneFactory>) -> some View {
        switch screen {
        case .login: ContentView(text: "login")
        case .registration: ContentView(text: "reg")
        case .succesfulRegistration: ContentView(text: "successReg")
        }
    }
}
