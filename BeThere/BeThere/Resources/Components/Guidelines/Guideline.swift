import SwiftUI

extension Guidelines {
    struct Guideline: View {
        var text: Binding<String>
        var type: ValidationType

        var body: some View {
            Label {
                Text(type.title).textStyle(.footnote)
            } icon: {
                type.validator(text.wrappedValue).image
                    .fittedToSize(.smallIconSize)
                    .foregroundColor(type.validator(text.wrappedValue).color)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }

        init(type: ValidationType, text: Binding<String>) {
            self.type = type
            self.text = text
        }
    }
}
