import SwiftUI

public struct UserList: View {
    var users: [User]
    var action: (User) -> Void

    public var body: some View {
        ForEach(users.indices, id: \.self) { idx in
            let user = users[idx]
            Card {
                HStack {
                    Text(user.name)
                    Spacer()
                    IconButton(.plus) {
                        action(user)
                    }
                }
            }
        }
    }

    public init(users: [User], action: @escaping (User) -> Void) {
        self.users = users
        self.action = action
    }
}

#if DEBUG
struct UserList_Previews: PreviewProvider {
    static var previews: some View {
        UserList(users: []) { _ in }
    }
}
#endif
