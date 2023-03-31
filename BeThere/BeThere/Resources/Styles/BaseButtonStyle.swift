import BaseKit
import SwiftUI

public struct BaseButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? .primary : .background)
            .textStyle(.headline)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.padding16)
            .overlay {
                RoundedRectangle(cornerRadius: .cornerRadius)
                    .stroke(isEnabled ? Color.primary : Color.clear, lineWidth: .borderWidth)
            }
            .background(
                RoundedRectangle(cornerRadius: .cornerRadius)
                    .fill(
                        isEnabled ? (configuration.isPressed ? Color.background : Color.primary) : Color.primary.opacity(.reducedOpacityValue)
                    )
            )
    }
}
