import SwiftUI

struct SettingsView {
    private typealias Str = Txt.Settings
    @StateObject var viewModel: SettingsViewModel
}

extension SettingsView: View {
    var body: some View {
        VStack {
            Image.profilePicture
            TextField(text: $viewModel.name) {
                Text(String.empty)
            }
            Spacer()
            Button(Str.saveLabel, action: viewModel.didTapSave)
        }
    }
}

#if DEBUG
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: .mock)
    }
}
#endif
