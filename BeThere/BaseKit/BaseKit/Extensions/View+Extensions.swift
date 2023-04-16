import SwiftUI

public extension View {
    func scalingAppearance() -> some View {
        modifier(ScaleAppearanceModifier())
    }

    func handlesNetworkError() -> some View {
        ZStack {
            self
            NetworkOverlay()
        }
    }
}
