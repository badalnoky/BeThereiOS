import BaseKit
import SwiftUI

struct SearchView {
    private typealias Str = Txt.Search
    @StateObject var viewModel: SearchViewModel
}

extension SearchView: View {
    var body: some View {
        VStack {
            StyledField(style: .search, title: Str.searchLabel, text: $viewModel.searchString)
            Divider().styledDivider()
            ScrollView {
                VStack(spacing: .padding8) {
                    UserList(users: viewModel.otherUsers, action: viewModel.didTapAdd(friend:))
                }
            }
        }
        .defaultNavigationBar(title: Str.title)
        .defaultViewSettings()
    }
}

#if DEBUG
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SearchView(viewModel: .mock)
        }
    }
}
#endif
