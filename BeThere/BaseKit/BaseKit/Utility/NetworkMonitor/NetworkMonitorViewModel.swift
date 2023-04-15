import Combine
import SwiftUI

public final class NetworkMonitorViewModel: ObservableObject {
    private var networkMonitor: NetworkMonitorServiceInput
    private var cancellables = Set<AnyCancellable>()

    @Published public var displayAlert: Bool

    public init(networkMonitor: NetworkMonitorServiceInput = NetworkMonitorService.shared) {
        self.displayAlert = false
        self.networkMonitor = networkMonitor
        networkMonitor.connectionState
            .sink { connected in
                withAnimation {
                    self.displayAlert = !connected
                }
            }.store(in: &cancellables)
    }
}
