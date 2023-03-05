import Combine
import SwiftUI

// swiftlint: disable: explicit_init

protocol CoordinatorInput {
    associatedtype Factory: SceneFactory

    var isFlowFinished: PassthroughSubject<Bool, Never> { get }
    var cancellables: Set<AnyCancellable> { get }
    var navigator: Navigator<Factory> { get }

    init(root: Factory.FlowScreen)

    func registerBinding()
}

extension CoordinatorInput {
    @ViewBuilder func start() -> some View { navigator }
}

open class Coordinator<Factory: SceneFactory>: CoordinatorInput {
    var isFlowFinished = PassthroughSubject<Bool, Never>()
    var cancellables = Set<AnyCancellable>()
    var navigator: Navigator<Factory>

    public required init(root: Factory.FlowScreen) {
        self.navigator = Navigator(sceneFactory: Factory.init(), root: root)
        registerBinding()
    }

    func registerBinding() {
        navigator.flowFinished.subscribe(isFlowFinished).store(in: &cancellables)
    }
}
