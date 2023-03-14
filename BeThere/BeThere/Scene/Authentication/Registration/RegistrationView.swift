import SwiftUI

struct RegistrationView {
    private typealias Str = Txt.Registration
    @StateObject var viewModel: RegistrationViewModel
}

extension RegistrationView: View {
    var body: some View {
        VStack {
            Group {
                Text(Str.emailLabel)
                TextField(text: $viewModel.email) {
                    Text(String.empty)
                }
                Text(Str.firstNameLabel)
                TextField(text: $viewModel.firstName) {
                    Text(String.empty)
                }
                Text(Str.lastNameLabel)
                TextField(text: $viewModel.lastName) {
                    Text(String.empty)
                }
                Text(Str.passwordLabel)
                TextField(text: $viewModel.password) {
                    Text(String.empty)
                }
                Text(Str.passwordAgainLabel)
                TextField(text: $viewModel.passwordAgain) {
                    Text(String.empty)
                }
            }
            Button(Str.registrateLabel, action: viewModel.didTapRegistrate)
        }
        .navigationTitle(Str.title)
    }
}

#if DEBUG
struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView(viewModel: .mock)
    }
}
#endif
