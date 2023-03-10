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
                Image.search
            }
            ScrollView {
                Divider()
                Text(Str.friendsLabel)
                ForEach(viewModel.friends, id: \.self) { friend in
                    Text(friend)
                }
                Divider()
                Text(Str.otherLabel)
                ForEach(viewModel.otherUsers, id: \.self) { user in
                    Text(user)
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
