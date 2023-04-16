import SwiftUI

public struct ListPlaceholder: View {
    private var text: String
    public var body: some View {
        VStack(alignment: .center) {
            Text(text)
                .foregroundColor(.appAccentColor)
                .textStyle(.headline)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    public init(_ text: String) {
        self.text = text
    }
}

#if DEBUG
struct ListPlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        ListPlaceholder(.person)
    }
}
#endif
