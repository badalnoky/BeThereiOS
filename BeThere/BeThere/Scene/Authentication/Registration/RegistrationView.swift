import SwiftUI

struct RegistrationView {
    private typealias Str = Txt.Registration
    @StateObject var viewModel: RegistrationViewModel
    @FocusState private var focusField: RegistrationFocusField?
}

extension RegistrationView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: .padding32) {
                StyledField(style: .email, title: Str.emailLabel, text: $viewModel.email)
                    .submitLabel(.next).focused($focusField, equals: .email)
                StyledField(style: .name, title: Str.firstNameLabel, text: $viewModel.firstName)
                    .submitLabel(.next).focused($focusField, equals: .firstName)
                StyledField(style: .name, title: Str.lastNameLabel, text: $viewModel.lastName)
                    .submitLabel(.next).focused($focusField, equals: .lastName)
                StyledField(style: .newPassword, title: Str.passwordLabel, text: $viewModel.password)
                    .submitLabel(.next).focused($focusField, equals: .password)
                Guidelines(guidelines: [.length, .lowerCase, .upperCase, .numeric], text: $viewModel.password)
                StyledField(title: Str.passwordAgainLabel, text: $viewModel.passwordAgain, validateText: $viewModel.password)
                    .focused($focusField, equals: .passwordAgain)
                Button(Str.registrateLabel, action: viewModel.didTapRegistrate)
                    .buttonStyle(BaseButtonStyle())
                    .disabled(viewModel.submitDisabled)
            }
            .padding(.padding16)
        }
        .defaultNavigationBar(title: Str.title)
        .scrollableViewSettings()
        .alert(viewModel.alertText, isPresented: $viewModel.displayAlert) {
            Button(Str.dismissButton, role: .cancel) { }
        }
        .onSubmit {
            switch focusField {
            case .email: focusField = .firstName
            case .firstName: focusField = .lastName
            case .lastName: focusField = .password
            case .password: focusField = .passwordAgain
            default: focusField = RegistrationFocusField.none
            }
        }
    }
}

#if DEBUG
struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            RegistrationView(viewModel: .mock)
        }
    }
}
#endif
