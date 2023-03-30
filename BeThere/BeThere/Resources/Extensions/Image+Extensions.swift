import SwiftUI

extension Image {
    private typealias Icons = Txt.Icons

    static var checkMark = Image(systemName: Icons.check)
    static var signOut = Image(systemName: Icons.signOut)
    static var addFriends = Image(systemName: Icons.addFriends)
    static var settings = Image(systemName: Icons.settings)
    static var search = Image(systemName: Icons.search)
    static var plus = Image(systemName: Icons.plus)
    static var edit = Image(systemName: Icons.edit)
    static var send = Image(systemName: Icons.send)
    static var profilePicture = Image(systemName: Icons.profilePicture)
    static var back = Image(systemName: Icons.back)
}

extension Image {
    func fittedToSize(_ size: CGFloat) -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
    }
}
