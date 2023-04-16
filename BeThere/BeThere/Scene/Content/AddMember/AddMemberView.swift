import BaseKit
import SwiftUI

struct AddMemberView {
    private typealias Str = Txt.AddMember
    @StateObject var viewModel: AddMemberViewModel
}

extension AddMemberView: View {
    var body: some View {
        VStack(spacing: .padding8) {
            StyledField(style: .search, title: Str.searchLabel, text: $viewModel.searchString)
            Divider().styledDivider()
            ScrollView {
                VStack(spacing: .padding8) {
                    Text(Str.friendsLabel)
                        .textStyle(.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    UserList(users: viewModel.friends, action: viewModel.didTapAdd(user:))
                        .withPlaceHolder(collection: viewModel.friends, text: Str.friendPlaceholderText)
                    Divider().styledDivider()
                        .padding(.top, .padding8)
                    Text(Str.otherLabel)
                        .textStyle(.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    UserList(users: viewModel.otherUsers, action: viewModel.didTapAdd(user:))
                        .withPlaceHolder(collection: viewModel.otherUsers, text: Str.otherPlaceholderText)
                }
            }
        }
        .defaultNavigationBar(title: Str.title)
        .defaultViewSettings()
    }
}

#if DEBUG
struct AddMemberView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddMemberView(viewModel: .mock)
        }
    }
}
#endif
