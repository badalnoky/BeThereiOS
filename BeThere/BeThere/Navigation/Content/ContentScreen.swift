import BaseKit

public enum ContentScreen: Screen {
    case main
    case settings
    case search
    case chat
    case event(_: String)
    case addMember
}
