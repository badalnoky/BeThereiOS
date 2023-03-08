// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Txt {
  internal enum Login {
    /// Email
    internal static let emailLabel = Txt.tr("Localizable", "Login.emailLabel", fallback: "Email")
    /// Password
    internal static let passwordLabel = Txt.tr("Localizable", "Login.passwordLabel", fallback: "Password")
    /// registrate
    internal static let registrateLabel = Txt.tr("Localizable", "Login.registrateLabel", fallback: "registrate")
    /// Sign in
    internal static let signInLabel = Txt.tr("Localizable", "Login.signInLabel", fallback: "Sign in")
    /// Sign in
    internal static let title = Txt.tr("Localizable", "Login.title", fallback: "Sign in")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Txt {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
