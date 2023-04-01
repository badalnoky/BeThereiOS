import BaseKit
import SwiftUI

struct MainView {
    private typealias Str = Txt.Main
    @StateObject var viewModel: MainViewModel
}

extension MainView: View {
    var body: some View {
        VStack(spacing: .padding8) {
            StyledField(style: .search, title: Str.searchLabel, text: $viewModel.searchString)
            Divider().styledDivider()
                .padding(.bottom, .padding8)
            ScrollView {
                VStack(spacing: .padding8) {
                    ForEach(viewModel.filteredEvents.indices, id: \.self) { idx in
                        let event = viewModel.filteredEvents[idx]
                        Button {
                            viewModel.didTapEvent(id: event.id)
                        } label: {
                            Card {
                                Text(event.name).frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }
                }
            }
            Button(Str.createLabel, action: viewModel.didTapCreate)
                .buttonStyle(BaseButtonStyle())
        }
        .mainNavigationBar(
            signOutAction: viewModel.didTapSignOut,
            searchAction: viewModel.didTapAddFriends,
            settingsAction: viewModel.didTapSettings
        )
        .defaultViewSettings()
    }
}

#if DEBUG
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MainView(viewModel: .mock)
        }
    }
}
#endif
