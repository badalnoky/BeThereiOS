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
            Divider()
            ScrollView {
                ForEach(viewModel.otherUsers.indices, id: \.self) { idx in
                    let user = viewModel.otherUsers[idx]
                    HStack {
                        Text(user.name)
                        Spacer()
                        IconButton(.plus) {
                            viewModel.didTapAdd(friend: user)
                        }
                    }
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
