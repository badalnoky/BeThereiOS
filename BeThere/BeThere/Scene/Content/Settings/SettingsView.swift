import BaseKit
import SwiftUI

struct SettingsView {
    private typealias Str = Txt.Settings
    @StateObject var viewModel: SettingsViewModel
}

extension SettingsView: View {
    var body: some View {
        VStack(spacing: .padding32) {
            AsyncImagePicker(
                url: viewModel.urlString,
                color: .appPrimary,
                size: .defaultImageSize,
                image: $viewModel.image,
                hasChanged: $viewModel.hasImageChanged
            )
            .padding(.top, .padding56)
            StyledField(style: .base, title: .empty, text: $viewModel.name)
            Spacer()
            Button(Str.saveLabel, action: viewModel.didTapSave)
                .buttonStyle(BaseButtonStyle())
        }
        .defaultNavigationBar(title: Str.title)
        .defaultViewSettings()
        .alert(viewModel.alertText, isPresented: $viewModel.displayAlert) {
            Button(Str.dismissButton, role: .cancel) { }
        }
    }
}

#if DEBUG
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingsView(viewModel: .mock)
        }
    }
}
#endif
