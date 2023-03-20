import SwiftUI

struct SearchView {
    private typealias Str = Txt.Search
    @StateObject var viewModel: SearchViewModel
}

extension SearchView: View {
    var body: some View {
        VStack {
            HStack {
                TextField(text: $viewModel.searchString) {
                    Text(Str.searchLabel)
                }
                IconButton(.search, action: viewModel.didTapSearch)
            }
            ScrollView {
                Divider()
                Text(Str.friendsLabel)
                ForEach(viewModel.friends, id: \.self) { friend in
                    Text(friend)
                }
                Divider()
                Text(Str.otherLabel)
                ForEach(viewModel.otherUsers.indices, id: \.self) { idx in
                    let user = viewModel.otherUsers[idx]
                    Text(user.name)
                }
            }
        }
        .navigationTitle(Str.title)
    }
}

#if DEBUG
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: .mock)
    }
}
#endif
