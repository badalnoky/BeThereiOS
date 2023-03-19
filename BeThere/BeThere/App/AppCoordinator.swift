import BaseKit
import Combine
import SwiftUI

class AppCoordinator: ObservableObject {
    enum AppFlow {
        case authentication
        case content
    }

    private let authenticationCoordinator: AuthenticationCoordinator
    private let contentCoordinator: ContentCoordinator

    @Published var activeFlow: AppFlow = .authentication

    init(authenticationCoordinator: AuthenticationCoordinator, contentCoordinator: ContentCoordinator) {
        self.authenticationCoordinator = authenticationCoordinator
        self.contentCoordinator = contentCoordinator
        registerBindings()
    }

    @ViewBuilder
    func view(for screen: AppFlow) -> some View {
        switch screen {
        case .authentication: authenticationCoordinator.start()
        case .content: contentCoordinator.start()
        }
    }

    func registerBindings() {
        Publishers.MergeMany([
            authenticationCoordinator.isFlowFinished.mapTo(screen: AppFlow.content),
            contentCoordinator.isFlowFinished.mapTo(screen: AppFlow.authentication)
        ]).assign(to: &$activeFlow)
    }
}
