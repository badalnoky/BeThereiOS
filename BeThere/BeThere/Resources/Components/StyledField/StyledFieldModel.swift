import SwiftUI

public enum StyledFieldStyle {
    case email
    case password
    case newPassword
    case passwordAgain
    case name
    case search
    case base

    var keyboardType: UIKeyboardType {
        switch self {
        case .email: return .emailAddress
        case .password: return .default
        case .newPassword: return .default
        case .passwordAgain: return .default
        case .name: return .default
        case .search: return .default
        case .base: return .default
        }
    }

    var textType: UITextContentType {
        switch self {
        case .email: return .emailAddress
        case .password: return .password
        case .newPassword: return .newPassword
        case .passwordAgain: return .newPassword
        case .name: return .name
        case .search: return .name
        case .base: return .name
        }
    }

    var capitalizationType: UITextAutocapitalizationType {
        switch self {
        case .email: return .none
        case .password: return .none
        case .newPassword: return .none
        case .passwordAgain: return .none
        case .name: return .words
        case .search: return .words
        case .base: return .sentences
        }
    }

    var icon: Image? {
        switch self {
        case .email: return Image.email
        case .password: return Image.password
        case .newPassword: return Image.password
        case .passwordAgain: return Image.password
        case .name: return Image.name
        case .search: return Image.search
        case .base: return nil
        }
    }
}
