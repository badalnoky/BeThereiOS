// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Txt {
  internal enum AddMember {
    /// Your Friends
    internal static let friendsLabel = Txt.tr("Localizable", "AddMember.friendsLabel", fallback: "Your Friends")
    /// Other users
    internal static let otherLabel = Txt.tr("Localizable", "AddMember.otherLabel", fallback: "Other users")
    /// Name of a person
    internal static let searchLabel = Txt.tr("Localizable", "AddMember.searchLabel", fallback: "Name of a person")
    /// Add people
    internal static let title = Txt.tr("Localizable", "AddMember.title", fallback: "Add people")
  }
  internal enum Chat {
    /// Time and Date
    internal static let dateLabel = Txt.tr("Localizable", "Chat.dateLabel", fallback: "Time and Date")
    /// Location
    internal static let locationLabel = Txt.tr("Localizable", "Chat.locationLabel", fallback: "Location")
  }
  internal enum Data {
    /// profilePicture
    internal static let defaultImagePath = Txt.tr("Localizable", "Data.defaultImagePath", fallback: "profilePicture")
    /// image/jpeg
    internal static let defaultImageType = Txt.tr("Localizable", "Data.defaultImageType", fallback: "image/jpeg")
    /// friends
    internal static let friends = Txt.tr("Localizable", "Data.friends", fallback: "friends")
    /// id
    internal static let id = Txt.tr("Localizable", "Data.id", fallback: "id")
    /// name
    internal static let name = Txt.tr("Localizable", "Data.name", fallback: "name")
    /// photo
    internal static let photo = Txt.tr("Localizable", "Data.photo", fallback: "photo")
    /// user
    internal static let userCollection = Txt.tr("Localizable", "Data.userCollection", fallback: "user")
  }
  internal enum Event {
    /// date
    internal static let date = Txt.tr("Localizable", "Event.date", fallback: "date")
    /// id
    internal static let id = Txt.tr("Localizable", "Event.id", fallback: "id")
    /// location
    internal static let location = Txt.tr("Localizable", "Event.location", fallback: "location")
    /// messages
    internal static let messages = Txt.tr("Localizable", "Event.messages", fallback: "messages")
    /// name
    internal static let name = Txt.tr("Localizable", "Event.name", fallback: "name")
    /// newUsers
    internal static let newUsers = Txt.tr("Localizable", "Event.newUsers", fallback: "newUsers")
    /// users
    internal static let users = Txt.tr("Localizable", "Event.users", fallback: "users")
  }
  internal enum EventData {
    /// event
    internal static let eventCollection = Txt.tr("Localizable", "EventData.eventCollection", fallback: "event")
    /// events
    internal static let events = Txt.tr("Localizable", "EventData.events", fallback: "events")
    /// id
    internal static let id = Txt.tr("Localizable", "EventData.id", fallback: "id")
    /// messages
    internal static let messages = Txt.tr("Localizable", "EventData.messages", fallback: "messages")
    /// newUsers
    internal static let newUsers = Txt.tr("Localizable", "EventData.newUsers", fallback: "newUsers")
    /// user
    internal static let userCollection = Txt.tr("Localizable", "EventData.userCollection", fallback: "user")
    /// users
    internal static let users = Txt.tr("Localizable", "EventData.users", fallback: "users")
  }
  internal enum EventScreen {
    /// Time and Date:
    internal static let dateLabel = Txt.tr("Localizable", "EventScreen.dateLabel", fallback: "Time and Date:")
    /// Location:
    internal static let locationLabel = Txt.tr("Localizable", "EventScreen.locationLabel", fallback: "Location:")
    /// Members
    internal static let membersLabel = Txt.tr("Localizable", "EventScreen.membersLabel", fallback: "Members")
    /// Name of event:
    internal static let nameLabel = Txt.tr("Localizable", "EventScreen.nameLabel", fallback: "Name of event:")
    /// Save
    internal static let saveLabel = Txt.tr("Localizable", "EventScreen.saveLabel", fallback: "Save")
  }
  internal enum Guidelines {
    /// At least 8 charachters long
    internal static let length = Txt.tr("Localizable", "Guidelines.length", fallback: "At least 8 charachters long")
    /// Contain an lowercase letter
    internal static let lowerCase = Txt.tr("Localizable", "Guidelines.lowerCase", fallback: "Contain an lowercase letter")
    /// Contain a number
    internal static let numeric = Txt.tr("Localizable", "Guidelines.numeric", fallback: "Contain a number")
    /// Password has to contain:
    internal static let title = Txt.tr("Localizable", "Guidelines.title", fallback: "Password has to contain:")
    /// Contain an uppercase letter
    internal static let upperCase = Txt.tr("Localizable", "Guidelines.upperCase", fallback: "Contain an uppercase letter")
  }
  internal enum Icons {
    /// person.fill.badge.plus
    internal static let addFriends = Txt.tr("Localizable", "Icons.addFriends", fallback: "person.fill.badge.plus")
    /// chevron.left
    internal static let back = Txt.tr("Localizable", "Icons.back", fallback: "chevron.left")
    /// eye.slash.fill
    internal static let discloseText = Txt.tr("Localizable", "Icons.discloseText", fallback: "eye.slash.fill")
    /// pencil
    internal static let edit = Txt.tr("Localizable", "Icons.edit", fallback: "pencil")
    /// envelope.fill
    internal static let email = Txt.tr("Localizable", "Icons.email", fallback: "envelope.fill")
    /// person.circle
    internal static let name = Txt.tr("Localizable", "Icons.name", fallback: "person.circle")
    /// checkmark.circle.fill
    internal static let obeyedGuideline = Txt.tr("Localizable", "Icons.obeyedGuideline", fallback: "checkmark.circle.fill")
    /// lock.fill
    internal static let password = Txt.tr("Localizable", "Icons.password", fallback: "lock.fill")
    /// plus.circle
    internal static let plus = Txt.tr("Localizable", "Icons.plus", fallback: "plus.circle")
    /// person.fill
    internal static let profilePicture = Txt.tr("Localizable", "Icons.profilePicture", fallback: "person.fill")
    /// magnifyingglass
    internal static let search = Txt.tr("Localizable", "Icons.search", fallback: "magnifyingglass")
    /// eye.fill
    internal static let seeText = Txt.tr("Localizable", "Icons.seeText", fallback: "eye.fill")
    /// paperplane
    internal static let send = Txt.tr("Localizable", "Icons.send", fallback: "paperplane")
    /// gear
    internal static let settings = Txt.tr("Localizable", "Icons.settings", fallback: "gear")
    /// rectangle.portrait.and.arrow.right
    internal static let signOut = Txt.tr("Localizable", "Icons.signOut", fallback: "rectangle.portrait.and.arrow.right")
    /// x.circle.fill
    internal static let violatedGuideline = Txt.tr("Localizable", "Icons.violatedGuideline", fallback: "x.circle.fill")
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
  internal enum Message {
    /// id
    internal static let id = Txt.tr("Localizable", "Message.id", fallback: "id")
    /// sentBy
    internal static let sentBy = Txt.tr("Localizable", "Message.sentBy", fallback: "sentBy")
    /// text
    internal static let text = Txt.tr("Localizable", "Message.text", fallback: "text")
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
  internal enum Search {
    /// Other users
    internal static let otherLabel = Txt.tr("Localizable", "Search.otherLabel", fallback: "Other users")
    /// Name of a person
    internal static let searchLabel = Txt.tr("Localizable", "Search.searchLabel", fallback: "Name of a person")
    /// Search
    internal static let title = Txt.tr("Localizable", "Search.title", fallback: "Search")
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
  internal enum User {
    /// events
    internal static let events = Txt.tr("Localizable", "User.events", fallback: "events")
    /// friends
    internal static let friends = Txt.tr("Localizable", "User.friends", fallback: "friends")
    /// id
    internal static let id = Txt.tr("Localizable", "User.id", fallback: "id")
    /// name
    internal static let name = Txt.tr("Localizable", "User.name", fallback: "name")
    /// photo
    internal static let photo = Txt.tr("Localizable", "User.photo", fallback: "photo")
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
