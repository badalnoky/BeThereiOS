import SwiftUI

struct LoginView {
    private typealias Str = Txt.Login
    @StateObject var viewModel: LoginViewModel
}

extension LoginView: View {
    var body: some View {
        VStack {
            Text(Str.emailLabel)
            TextField(text: $viewModel.email) {
                Text(String.empty)
            }
            Text(Str.passwordLabel)
            TextField(text: $viewModel.password) {
                Text(String.empty)
            }
            Button(Str.registrateLabel, action: viewModel.didTapRegistrate)
            Button(Str.signInLabel, action: viewModel.didTapLogin)
        }
        .navigationTitle(Str.title)
    }
}

#if DEBUG
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: .mock)
    }
}
#endif
