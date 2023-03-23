import BaseKit

public enum ContentScreen: Screen {
    case main
    case settings
    case search
    case chat(_: String)
    case event(_: String)
    case addMember(_: String)
}
