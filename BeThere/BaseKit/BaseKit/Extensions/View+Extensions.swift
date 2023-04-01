import SwiftUI

public extension View {
    func scalingAppearance() -> some View {
        modifier(ScaleAppearanceModifier())
    }
}
