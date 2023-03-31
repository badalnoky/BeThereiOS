import SwiftUI

public struct Guidelines: View {
    private typealias Str = Txt.Guidelines
    var guidelines: [ValidationType]
    var text: Binding<String>

    public var body: some View {
        VStack(spacing: .padding8) {
            Text(Str.title)
                .textStyle(.callout)
                .frame(maxWidth: .infinity, alignment: .leading)

            ForEach(guidelines, id: \.self) { guideline in
                Guideline(type: guideline, text: text)
            }
        }
    }

    public init(guidelines: [ValidationType], text: Binding<String>) {
        self.guidelines = guidelines
        self.text = text
    }
}

#if DEBUG
struct Guidelines_Previews: PreviewProvider {
    @State static var text: String = .empty
    static var previews: some View {
        Guidelines(guidelines: [.length, .numeric], text: $text)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
#endif
