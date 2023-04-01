import BaseKit
import SwiftUI

extension Image {
    private typealias Icons = Txt.Icons

    static var signOut = Image(systemName: Icons.signOut)
    static var addFriends = Image(systemName: Icons.addFriends)
    static var settings = Image(systemName: Icons.settings)
    static var plus = Image(systemName: Icons.plus)
    static var edit = Image(systemName: Icons.edit)
    static var send = Image(systemName: Icons.send)
    static var profilePicture = Image(systemName: Icons.profilePicture)
    static var back = Image(systemName: Icons.back)
    static var obeyed = Image(systemName: Icons.obeyedGuideline)
    static var violated = Image(systemName: Icons.violatedGuideline)
    static var email = Image(systemName: Icons.email)
    static var password = Image(systemName: Icons.password)
    static var name = Image(systemName: Icons.name)
    static var search = Image(systemName: Icons.search)
    static var seeText = Image(systemName: Icons.seeText)
    static var discloseText = Image(systemName: Icons.discloseText)
}

extension Image {
    func textFieldIcon() -> some View {
        self
            .fittedToSize(.defaultIconSize)
            .foregroundColor(.appAccentColor)
    }
}
