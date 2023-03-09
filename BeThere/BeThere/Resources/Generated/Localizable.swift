// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Txt {
  internal enum Icons {
    /// person.fill.badge.plus
    internal static let addFriends = Txt.tr("Localizable", "Icons.addFriends", fallback: "person.fill.badge.plus")
    /// checkmark
    internal static let check = Txt.tr("Localizable", "Icons.check", fallback: "checkmark")
    /// pencil
    internal static let edit = Txt.tr("Localizable", "Icons.edit", fallback: "pencil")
    /// plus
    internal static let plus = Txt.tr("Localizable", "Icons.plus", fallback: "plus")
    /// person.fill
    internal static let profilePicture = Txt.tr("Localizable", "Icons.profilePicture", fallback: "person.fill")
    /// magnifyingglass
    internal static let search = Txt.tr("Localizable", "Icons.search", fallback: "magnifyingglass")
    /// paperplane
    internal static let send = Txt.tr("Localizable", "Icons.send", fallback: "paperplane")
    /// gear
    internal static let settings = Txt.tr("Localizable", "Icons.settings", fallback: "gear")
    /// rectangle.portrait.and.arrow.right
    internal static let signOut = Txt.tr("Localizable", "Icons.signOut", fallback: "rectangle.portrait.and.arrow.right")
  }
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
  internal enum Main {
    /// Create an event
    internal static let createLabel = Txt.tr("Localizable", "Main.createLabel", fallback: "Create an event")
    /// Search
    internal static let searchLabel = Txt.tr("Localizable", "Main.searchLabel", fallback: "Search")
  }
  internal enum Registration {
    /// Email
    internal static let emailLabel = Txt.tr("Localizable", "Registration.emailLabel", fallback: "Email")
    /// First name
    internal static let firstNameLabel = Txt.tr("Localizable", "Registration.firstNameLabel", fallback: "First name")
    /// Last name
    internal static let lastNameLabel = Txt.tr("Localizable", "Registration.lastNameLabel", fallback: "Last name")
    /// Password again
    internal static let passwordAgainLabel = Txt.tr("Localizable", "Registration.passwordAgainLabel", fallback: "Password again")
    /// Password
    internal static let passwordLabel = Txt.tr("Localizable", "Registration.passwordLabel", fallback: "Password")
    /// Registrate
    internal static let registrateLabel = Txt.tr("Localizable", "Registration.registrateLabel", fallback: "Registrate")
    /// Registration
    internal static let title = Txt.tr("Localizable", "Registration.title", fallback: "Registration")
  }
  internal enum Settings {
    /// Save
    internal static let saveLabel = Txt.tr("Localizable", "Settings.saveLabel", fallback: "Save")
  }
  internal enum SuccessfulRegistration {
    /// Next
    internal static let nextLabel = Txt.tr("Localizable", "SuccessfulRegistration.nextLabel", fallback: "Next")
    /// Successful registration
    internal static let title = Txt.tr("Localizable", "SuccessfulRegistration.title", fallback: "Successful registration")
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
