import BaseKit
import SwiftUI

public struct BaseButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? .appPrimary : .appBackground)
            .textStyle(.headline)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.padding16)
            .overlay {
                RoundedRectangle(cornerRadius: .cornerRadius)
                    .stroke(isEnabled ? Color.appPrimary : Color.clear, lineWidth: .borderWidth)
            }
            .background(
                RoundedRectangle(cornerRadius: .cornerRadius)
                    .fill(
                        isEnabled ?
                        (configuration.isPressed ? Color.appBackground : Color.appPrimary)
                        : Color.appPrimary.opacity(.reducedOpacityValue)
                    )
            )
    }
}
