import SwiftUI

public struct TextButtonStyle: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? .text.opacity(.reducedOpacityValue) : .text)
            .textStyle(.headline)
            .underline()
            .frame(maxWidth: .infinity, alignment: .center)
    }
}
