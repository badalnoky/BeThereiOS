import SwiftUI

struct MainView {
    private typealias Str = Txt.Main
    @StateObject var viewModel: MainViewModel
}

extension MainView: View {
    var body: some View {
        VStack {
            HStack {
                Image.signOut
                Spacer()
                Image.addFriends
                Image.settings
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
                }
            }
            Button(Str.createLabel) {}
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
