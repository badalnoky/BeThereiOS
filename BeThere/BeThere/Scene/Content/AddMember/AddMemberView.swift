import BaseKit
import SwiftUI

struct AddMemberView {
    private typealias Str = Txt.AddMember
    @StateObject var viewModel: AddMemberViewModel
}

extension AddMemberView: View {
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
                ForEach(viewModel.friends.indices, id: \.self) { idx in
                    let friend = viewModel.friends[idx]
                    HStack {
                        Text(friend.name)
                        Spacer()
                        IconButton(.plus) {
                            viewModel.didTapAdd(user: friend)
                        }
                    }
                }
                Divider()
                Text(Str.otherLabel)
                ForEach(viewModel.otherUsers.indices, id: \.self) { idx in
                    let user = viewModel.otherUsers[idx]
                    HStack {
                        Text(user.name)
                        Spacer()
                        IconButton(.plus) {
                            viewModel.didTapAdd(user: user)
                        }
                    }
                }
            }
        }
        .navigationTitle(Str.title)
    }
}

#if DEBUG
struct AddMemberView_Previews: PreviewProvider {
    static var previews: some View {
        AddMemberView(viewModel: .mock)
    }
}
#endif
