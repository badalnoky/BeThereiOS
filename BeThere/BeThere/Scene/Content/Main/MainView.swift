import BaseKit
import SwiftUI

struct MainView {
    private typealias Str = Txt.Main
    @StateObject var viewModel: MainViewModel
}

extension MainView: View {
    var body: some View {
        VStack {
            HStack {
                IconButton(.signOut, action: viewModel.didTapSignOut)
                Spacer()
                IconButton(.addFriends, action: viewModel.didTapAddFriends)
                IconButton(.settings, action: viewModel.didTapSettings)
            }
            HStack {
                TextField(text: $viewModel.searchString) {
                    Text(Str.searchLabel)
                }
                IconButton(.search, action: viewModel.didTapSearch)
            }
            Divider()
            ScrollView {
                ForEach(viewModel.filteredEvents.indices, id: \.self) { idx in
                    let event = viewModel.filteredEvents[idx]
                    Button(event.name) {
                        viewModel.didTapEvent(id: event.id)
                    }
                }
            }
            Button(Str.createLabel, action: viewModel.didTapCreate)
        }
    }
}

#if DEBUG
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: .mock)
    }
}
#endif
