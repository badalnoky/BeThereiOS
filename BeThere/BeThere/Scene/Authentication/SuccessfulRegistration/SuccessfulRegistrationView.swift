import SwiftUI

struct SuccessfulRegistrationView {
    private typealias Str = Txt.SuccessfulRegistration
    @StateObject var viewModel: SuccessfulRegistrationViewModel
}

extension SuccessfulRegistrationView: View {
    var body: some View {
        VStack {
            Text(Str.title).textStyle(.largeTitle)
            Spacer()
            Lottie(named: Lotties.succesfulRegistration)
            Spacer()
            Button(Str.nextLabel, action: viewModel.didTapNext)
                .buttonStyle(BaseButtonStyle())
        }
        .defaultViewSettings()
    }
}

#if DEBUG
struct SuccessfulRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
            SuccessfulRegistrationView(viewModel: .mock)
    }
}
#endif
