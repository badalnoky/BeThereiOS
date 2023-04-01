import SwiftUI

public struct Card<Content: View> {
    let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
}

extension Card: View {
    public var body: some View {
        content
            .textStyle(.body)
            .foregroundColor(.appAccentColor)
            .padding(.padding16)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: .cornerRadius)
                    .fill(Color.appSecondary)
            )
    }
}

#if DEBUG
struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Card {
            HStack {
                Text(Txt.Search.searchLabel)
                Spacer()
                IconButton(.plus) {}
            }
        }
        .padding(.padding16)
    }
}
#endif
