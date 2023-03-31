import SwiftUI

public struct IconButton: View {
    private var icon: Image
    private var action: () -> Void

    public var body: some View {
        Button(action: action) {
            icon
                .fittedToSize(.defaultIconSize)
                .foregroundColor(.primary)
        }
    }

    public init(_ icon: Image, action: @escaping () -> Void) {
        self.icon = icon
        self.action = action
    }
}

#if DEBUG
struct IconButton_Previews: PreviewProvider {
    static var previews: some View {
        IconButton(Image(systemName: .person)) {}
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
#endif
