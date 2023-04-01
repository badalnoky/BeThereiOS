import SwiftUI

struct RegistrationView {
    private typealias Str = Txt.Registration
    @StateObject var viewModel: RegistrationViewModel
}

extension RegistrationView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: .padding32) {
                StyledField(style: .email, title: Str.emailLabel, text: $viewModel.email)
                StyledField(style: .name, title: Str.firstNameLabel, text: $viewModel.firstName)
                StyledField(style: .name, title: Str.lastNameLabel, text: $viewModel.lastName)
                StyledField(style: .newPassword, title: Str.passwordLabel, text: $viewModel.password)
                Guidelines(guidelines: [.length, .lowerCase, .upperCase, .numeric], text: $viewModel.password)
                StyledField(title: Str.passwordAgainLabel, text: $viewModel.passwordAgain, validateText: $viewModel.password)
                Button(Str.registrateLabel, action: viewModel.didTapRegistrate)
                    .buttonStyle(BaseButtonStyle())
            }
            .padding(.padding16)
        }
        .defaultNavigationBar(title: Str.title)
        .scrollableViewSettings()
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
