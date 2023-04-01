import SwiftUI

struct LoginView {
    private typealias Str = Txt.Login
    @StateObject var viewModel: LoginViewModel
}

extension LoginView: View {
    var body: some View {
        VStack(spacing: .padding32) {
            StyledField(style: .email, title: Str.emailLabel, text: $viewModel.email)
            StyledField(style: .password, title: Str.passwordLabel, text: $viewModel.password)
            Button(Str.registrateLabel, action: viewModel.didTapRegistrate)
                .buttonStyle(TextButtonStyle())
            Spacer()
            Button(Str.signInLabel, action: viewModel.didTapLogin)
                .buttonStyle(BaseButtonStyle())
        }
        .defaultNavigationBar(title: Str.title, isNavigatable: false)
        .defaultViewSettings()
    }
}

#if DEBUG
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LoginView(viewModel: .mock)
        }
    }
}
#endif
