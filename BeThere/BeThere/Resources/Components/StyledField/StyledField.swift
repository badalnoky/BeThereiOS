import BaseKit
import SwiftUI

public struct StyledField {
    private let style: StyledFieldStyle
    private let title: String
    private let text: Binding<String>
    private let validateText: Binding<String>?

    @FocusState private var focusState: Bool
    @State private var isFocused = false
    @State private var isSecured: Bool

    public init(
        style: StyledFieldStyle,
        title: String,
        text: Binding<String>
    ) {
        self.style = style
        self.title = title
        self.text = text
        self.isSecured = (style == .password || style == .newPassword || style == .passwordAgain)
        self.validateText = nil
    }

    public init(
        title: String,
        text: Binding<String>,
        validateText: Binding<String>
    ) {
        self.style = .passwordAgain
        self.title = title
        self.text = text
        self.isSecured = true
        self.validateText = validateText
    }
}

extension StyledField: View {
    public var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            HStack(alignment: .center, spacing: .zero) {
                if let icon = style.icon {
                    icon
                        .textFieldIcon()
                        .padding(.trailing, .padding16)
                }

                textField

                if style == .password || style == .newPassword || style == .passwordAgain {
                    Button {
                        isSecured.toggle()
                    } label: {
                        if isSecured {
                            Image.seeText
                                .textFieldIcon()
                        } else {
                            Image.discloseText
                                .textFieldIcon()
                        }
                    }
                }
            }
            .padding(.padding16)
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .textFieldOverlay(isFocused: isFocused, isValid: validator())
    }
}

private extension StyledField {
    var textField: some View {
        Group {
            if (style == .password || style == .newPassword || style == .passwordAgain) && isSecured {
                SecureField(title, text: text)
            } else {
                TextField(title, text: text)
            }
        }
        .focused($focusState)
        .textStyle(.body)
        .keyboardSettings(for: style)
        .onChange(of: focusState) { newValue in
            isFocused = newValue
        }
    }

    var validator: () -> Bool {
        if style == .email {
            return {
                NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
                    .evaluate(with: text.wrappedValue) || text.wrappedValue.isEmpty
            }
        } else if style == .passwordAgain {
            return {
                (text.wrappedValue == validateText?.wrappedValue) || text.wrappedValue.isEmpty
            }
        }

        return {
            true
        }
    }
}

#if DEBUG
struct StyledField_Previews: PreviewProvider {
    @State static var text: String = .empty

    static var previews: some View {
        VStack(spacing: .padding16) {
            StyledField(style: .email, title: "Email", text: $text)
            StyledField(style: .password, title: "Password", text: $text)
            StyledField(style: .name, title: "Name", text: $text)
            StyledField(style: .search, title: "Search", text: $text)
            StyledField(style: .base, title: "Send a message", text: $text)
        }
        .padding(.horizontal, .padding16)
        .previewLayout(.sizeThatFits)
    }
}
#endif
