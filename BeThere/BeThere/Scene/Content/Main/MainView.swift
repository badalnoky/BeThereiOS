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
                Image.search
            }
            Divider()
            ScrollView {
                ForEach(viewModel.events, id: \.self) { event in
                    Text(event)
                        .onTapGesture {
                            viewModel.didTapEvent()
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
