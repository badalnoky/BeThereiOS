import SwiftUI

public enum ValidationStatus {
    case obeyed, violated

    var image: Image {
        switch self {
        case .obeyed: return .obeyed
        case .violated: return .violated
        }
    }

    var color: Color {
        switch self {
        case .obeyed: return .success
        case .violated: return .error
        }
    }
}

public enum ValidationType {
    case length, numeric, upperCase, lowerCase

    private typealias Str = Txt.Guidelines

    var validator: (String) -> ValidationStatus {
        switch self {
        case .length:
            return { text in
                text.count > 7 ? .obeyed : .violated
            }
        case .numeric:
            return { text in
                let value = NSPredicate(format: "SELF MATCHES %@", ".*[0-9]+.*").evaluate(with: text)
                return  value ? .obeyed : .violated
            }
        case .upperCase:
            return { text in
                let value = NSPredicate(format: "SELF MATCHES %@", ".*[A-Z]+.*").evaluate(with: text)
                return  value ? .obeyed : .violated
            }
        case .lowerCase:
            return { text in
                let value = NSPredicate(format: "SELF MATCHES %@", ".*[a-z]+.*").evaluate(with: text)
                return  value ? .obeyed : .violated
            }
        }
    }

    var title: String {
        switch self {
        case .length: return Str.length
        case .numeric: return Str.numeric
        case .upperCase: return Str.upperCase
        case .lowerCase: return Str.lowerCase
        }
    }
}
