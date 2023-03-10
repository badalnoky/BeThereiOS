import SwiftUI

struct SuccessfulRegistrationView {
    private typealias Str = Txt.SuccessfulRegistration
    @StateObject var viewModel: SuccessfulRegistrationViewModel
}

extension SuccessfulRegistrationView: View {
    var body: some View {
        VStack {
            Image.checkMark
                .resizable()
                .scaledToFit()
            Button(Str.nextLabel) {}
        }
    }
}

#if DEBUG
struct SuccessfulRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessfulRegistrationView(viewModel: .mock)
    }
}
#endif
