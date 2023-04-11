// Generated using Sourcery 2.0.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint: disable: type_contents_order
// swiftlint: disable: implicitly_unwrapped_optional
// swiftlint: disable: line_length
// swiftlint: disable: identifier_name
// swiftlint: disable: let_var_whitespace

import BeThere
import Combine
import UIKit

public class AuthenticationServiceInputMock: AuthenticationServiceInput {
    public init() {}

    // MARK: - signIn

    public var signInEmailPasswordCallsCount = 0
    public var signInEmailPasswordCalled: Bool {
        signInEmailPasswordCallsCount > 0
    }
    public var signInEmailPasswordReceivedArguments: (email: String, password: String)?
    public var signInEmailPasswordReceivedInvocations: [(email: String, password: String)] = []
    public var signInEmailPasswordReturnValue: CurrentValueSubject<Bool, Error>!
    public var signInEmailPasswordClosure: ((String, String) -> CurrentValueSubject<Bool, Error>)?

    public func signIn(email: String, password: String) -> CurrentValueSubject<Bool, Error> {
        signInEmailPasswordCallsCount += 1
        signInEmailPasswordReceivedArguments = (email: email, password: password)
        signInEmailPasswordReceivedInvocations.append((email: email, password: password))
        if let signInEmailPasswordClosure = signInEmailPasswordClosure {
            return signInEmailPasswordClosure(email, password)
        } else {
            return signInEmailPasswordReturnValue
        }
    }
    // MARK: - registrate

    public var registrateEmailPasswordNameCallsCount = 0
    public var registrateEmailPasswordNameCalled: Bool {
        registrateEmailPasswordNameCallsCount > 0
    }
    public var registrateEmailPasswordNameReceivedArguments: (email: String, password: String, name: String)?
    public var registrateEmailPasswordNameReceivedInvocations: [(email: String, password: String, name: String)] = []
    public var registrateEmailPasswordNameReturnValue: CurrentValueSubject<Bool, Error>!
    public var registrateEmailPasswordNameClosure: ((String, String, String) -> CurrentValueSubject<Bool, Error>)?

    public func registrate(email: String, password: String, name: String) -> CurrentValueSubject<Bool, Error> {
        registrateEmailPasswordNameCallsCount += 1
        registrateEmailPasswordNameReceivedArguments = (email: email, password: password, name: name)
        registrateEmailPasswordNameReceivedInvocations.append((email: email, password: password, name: name))
        if let registrateEmailPasswordNameClosure = registrateEmailPasswordNameClosure {
            return registrateEmailPasswordNameClosure(email, password, name)
        } else {
            return registrateEmailPasswordNameReturnValue
        }
    }
    // MARK: - signOut

    public var signOutCallsCount = 0
    public var signOutCalled: Bool {
        signOutCallsCount > 0
    }
    public var signOutReturnValue: CurrentValueSubject<Bool, Error>!
    public var signOutClosure: (() -> CurrentValueSubject<Bool, Error>)?

    public func signOut() -> CurrentValueSubject<Bool, Error> {
        signOutCallsCount += 1
        if let signOutClosure = signOutClosure {
            return signOutClosure()
        } else {
            return signOutReturnValue
        }
    }
}
public class EventDataServiceInputMock: EventDataServiceInput {
    public init() {}
    public var userEvents: CurrentValueSubject<[Event], Never> {
        get { underlyingUserEvents }
        set(value) { underlyingUserEvents = value }
    }
    public var underlyingUserEvents: CurrentValueSubject<[Event], Never>!
    public var currentEvent: CurrentValueSubject<Event, Never> {
        get { underlyingCurrentEvent }
        set(value) { underlyingCurrentEvent = value }
    }
    public var underlyingCurrentEvent: CurrentValueSubject<Event, Never>!
    public var provisionalMembers: CurrentValueSubject<[User], Never> {
        get { underlyingProvisionalMembers }
        set(value) { underlyingProvisionalMembers = value }
    }
    public var underlyingProvisionalMembers: CurrentValueSubject<[User], Never>!

    // MARK: - getEvents

    public var getEventsForCallsCount = 0
    public var getEventsForCalled: Bool {
        getEventsForCallsCount > 0
    }
    public var getEventsForReceivedUser: User?
    public var getEventsForReceivedInvocations: [User] = []
    public var getEventsForClosure: ((User) -> Void)?

    public func getEvents(for user: User) {
        getEventsForCallsCount += 1
        getEventsForReceivedUser = user
        getEventsForReceivedInvocations.append(user)
        getEventsForClosure?(user)
    }
    // MARK: - createEvent

    public var createEventCallsCount = 0
    public var createEventCalled: Bool {
        createEventCallsCount > 0
    }
    public var createEventReceivedEvent: Event?
    public var createEventReceivedInvocations: [Event] = []
    public var createEventClosure: ((Event) -> Void)?

    public func createEvent(_ event: Event) {
        createEventCallsCount += 1
        createEventReceivedEvent = event
        createEventReceivedInvocations.append(event)
        createEventClosure?(event)
    }
    // MARK: - updateEvent

    public var updateEventWithDifferenceCallsCount = 0
    public var updateEventWithDifferenceCalled: Bool {
        updateEventWithDifferenceCallsCount > 0
    }
    public var updateEventWithDifferenceReceivedArguments: (id: String, difference: [String: Any])?
    public var updateEventWithDifferenceReceivedInvocations: [(id: String, difference: [String: Any])] = []
    public var updateEventWithDifferenceReturnValue: CurrentValueSubject<Bool, Never>!
    public var updateEventWithDifferenceClosure: ((String, [String: Any]) -> CurrentValueSubject<Bool, Never>)?

    public func updateEvent(with id: String, difference: [String: Any]) -> CurrentValueSubject<Bool, Never> {
        updateEventWithDifferenceCallsCount += 1
        updateEventWithDifferenceReceivedArguments = (id: id, difference: difference)
        updateEventWithDifferenceReceivedInvocations.append((id: id, difference: difference))
        if let updateEventWithDifferenceClosure = updateEventWithDifferenceClosure {
            return updateEventWithDifferenceClosure(id, difference)
        } else {
            return updateEventWithDifferenceReturnValue
        }
    }
    // MARK: - getEventData

    public var getEventDataForCallsCount = 0
    public var getEventDataForCalled: Bool {
        getEventDataForCallsCount > 0
    }
    public var getEventDataForReceivedId: String?
    public var getEventDataForReceivedInvocations: [String] = []
    public var getEventDataForClosure: ((String) -> Void)?

    public func getEventData(for id: String) {
        getEventDataForCallsCount += 1
        getEventDataForReceivedId = id
        getEventDataForReceivedInvocations.append(id)
        getEventDataForClosure?(id)
    }
    // MARK: - provisionallyAdd

    public var provisionallyAddUserCallsCount = 0
    public var provisionallyAddUserCalled: Bool {
        provisionallyAddUserCallsCount > 0
    }
    public var provisionallyAddUserReceivedUser: User?
    public var provisionallyAddUserReceivedInvocations: [User] = []
    public var provisionallyAddUserClosure: ((User) -> Void)?

    public func provisionallyAdd(user: User) {
        provisionallyAddUserCallsCount += 1
        provisionallyAddUserReceivedUser = user
        provisionallyAddUserReceivedInvocations.append(user)
        provisionallyAddUserClosure?(user)
    }
    // MARK: - send

    public var sendToCallsCount = 0
    public var sendToCalled: Bool {
        sendToCallsCount > 0
    }
    public var sendToReceivedArguments: (message: Message, eventId: String)?
    public var sendToReceivedInvocations: [(message: Message, eventId: String)] = []
    public var sendToClosure: ((Message, String) -> Void)?

    public func send(_ message: Message, to eventId: String) {
        sendToCallsCount += 1
        sendToReceivedArguments = (message: message, eventId: eventId)
        sendToReceivedInvocations.append((message: message, eventId: eventId))
        sendToClosure?(message, eventId)
    }
}
public class UserDataServiceInputMock: UserDataServiceInput {
    public init() {}
    public var user: CurrentValueSubject<User?, Never> {
        get { underlyingUser }
        set(value) { underlyingUser = value }
    }
    public var underlyingUser: CurrentValueSubject<User?, Never>!
    public var searchedUsers: CurrentValueSubject<[User], Never> {
        get { underlyingSearchedUsers }
        set(value) { underlyingSearchedUsers = value }
    }
    public var underlyingSearchedUsers: CurrentValueSubject<[User], Never>!
    public var searchedOtherMembers: CurrentValueSubject<[User], Never> {
        get { underlyingSearchedOtherMembers }
        set(value) { underlyingSearchedOtherMembers = value }
    }
    public var underlyingSearchedOtherMembers: CurrentValueSubject<[User], Never>!
    public var searchedFriendMembers: CurrentValueSubject<[User], Never> {
        get { underlyingSearchedFriendMembers }
        set(value) { underlyingSearchedFriendMembers = value }
    }
    public var underlyingSearchedFriendMembers: CurrentValueSubject<[User], Never>!
    public var eventMembers: CurrentValueSubject<[User], Never> {
        get { underlyingEventMembers }
        set(value) { underlyingEventMembers = value }
    }
    public var underlyingEventMembers: CurrentValueSubject<[User], Never>!

    // MARK: - resetUser

    public var resetUserCallsCount = 0
    public var resetUserCalled: Bool {
        resetUserCallsCount > 0
    }
    public var resetUserClosure: (() -> Void)?

    public func resetUser() {
        resetUserCallsCount += 1
        resetUserClosure?()
    }
    // MARK: - createUserDocument

    public var createUserDocumentWithNameCallsCount = 0
    public var createUserDocumentWithNameCalled: Bool {
        createUserDocumentWithNameCallsCount > 0
    }
    public var createUserDocumentWithNameReceivedArguments: (id: String, name: String)?
    public var createUserDocumentWithNameReceivedInvocations: [(id: String, name: String)] = []
    public var createUserDocumentWithNameReturnValue: CurrentValueSubject<Bool, Error>!
    public var createUserDocumentWithNameClosure: ((String, String) -> CurrentValueSubject<Bool, Error>)?

    public func createUserDocument(with id: String, name: String) -> CurrentValueSubject<Bool, Error> {
        createUserDocumentWithNameCallsCount += 1
        createUserDocumentWithNameReceivedArguments = (id: id, name: name)
        createUserDocumentWithNameReceivedInvocations.append((id: id, name: name))
        if let createUserDocumentWithNameClosure = createUserDocumentWithNameClosure {
            return createUserDocumentWithNameClosure(id, name)
        } else {
            return createUserDocumentWithNameReturnValue
        }
    }
    // MARK: - getUserData

    public var getUserDataForCallsCount = 0
    public var getUserDataForCalled: Bool {
        getUserDataForCallsCount > 0
    }
    public var getUserDataForReceivedId: String?
    public var getUserDataForReceivedInvocations: [String] = []
    public var getUserDataForClosure: ((String) -> Void)?

    public func getUserData(for id: String) {
        getUserDataForCallsCount += 1
        getUserDataForReceivedId = id
        getUserDataForReceivedInvocations.append(id)
        getUserDataForClosure?(id)
    }
    // MARK: - updateUserName

    public var updateUserNameToCallsCount = 0
    public var updateUserNameToCalled: Bool {
        updateUserNameToCallsCount > 0
    }
    public var updateUserNameToReceivedName: String?
    public var updateUserNameToReceivedInvocations: [String] = []
    public var updateUserNameToClosure: ((String) -> Void)?

    public func updateUserName(to name: String) {
        updateUserNameToCallsCount += 1
        updateUserNameToReceivedName = name
        updateUserNameToReceivedInvocations.append(name)
        updateUserNameToClosure?(name)
    }
    // MARK: - fetchUsers

    public var fetchUsersContainingCallsCount = 0
    public var fetchUsersContainingCalled: Bool {
        fetchUsersContainingCallsCount > 0
    }
    public var fetchUsersContainingReceivedSubstring: String?
    public var fetchUsersContainingReceivedInvocations: [String] = []
    public var fetchUsersContainingClosure: ((String) -> Void)?

    public func fetchUsers(containing substring: String) {
        fetchUsersContainingCallsCount += 1
        fetchUsersContainingReceivedSubstring = substring
        fetchUsersContainingReceivedInvocations.append(substring)
        fetchUsersContainingClosure?(substring)
    }
    // MARK: - fetchSearchedUsers

    public var fetchSearchedUsersContainingIsInitialFetchFilteringCallsCount = 0
    public var fetchSearchedUsersContainingIsInitialFetchFilteringCalled: Bool {
        fetchSearchedUsersContainingIsInitialFetchFilteringCallsCount > 0
    }
    public var fetchSearchedUsersContainingIsInitialFetchFilteringReceivedArguments: (substring: String, isInitialFetch: Bool, filtering: [User])?
    public var fetchSearchedUsersContainingIsInitialFetchFilteringReceivedInvocations: [(substring: String, isInitialFetch: Bool, filtering: [User])] = []
    public var fetchSearchedUsersContainingIsInitialFetchFilteringClosure: ((String, Bool, [User]) -> Void)?

    public func fetchSearchedUsers(containing substring: String, isInitialFetch: Bool, filtering: [User]) {
        fetchSearchedUsersContainingIsInitialFetchFilteringCallsCount += 1
        fetchSearchedUsersContainingIsInitialFetchFilteringReceivedArguments = (substring: substring, isInitialFetch: isInitialFetch, filtering: filtering)
        fetchSearchedUsersContainingIsInitialFetchFilteringReceivedInvocations.append((substring: substring, isInitialFetch: isInitialFetch, filtering: filtering))
        fetchSearchedUsersContainingIsInitialFetchFilteringClosure?(substring, isInitialFetch, filtering)
    }
    // MARK: - addFriend

    public var addFriendCallsCount = 0
    public var addFriendCalled: Bool {
        addFriendCallsCount > 0
    }
    public var addFriendReceivedFriend: User?
    public var addFriendReceivedInvocations: [User] = []
    public var addFriendClosure: ((User) -> Void)?

    public func addFriend(_ friend: User) {
        addFriendCallsCount += 1
        addFriendReceivedFriend = friend
        addFriendReceivedInvocations.append(friend)
        addFriendClosure?(friend)
    }
    // MARK: - fetchMembers

    public var fetchMembersCallsCount = 0
    public var fetchMembersCalled: Bool {
        fetchMembersCallsCount > 0
    }
    public var fetchMembersReceivedIds: [String]?
    public var fetchMembersReceivedInvocations: [[String]] = []
    public var fetchMembersClosure: (([String]) -> Void)?

    public func fetchMembers(_ ids: [String]) {
        fetchMembersCallsCount += 1
        fetchMembersReceivedIds = ids
        fetchMembersReceivedInvocations.append(ids)
        fetchMembersClosure?(ids)
    }
    // MARK: - upload

    public var uploadImageCallsCount = 0
    public var uploadImageCalled: Bool {
        uploadImageCallsCount > 0
    }
    public var uploadImageReceivedImage: UIImage?
    public var uploadImageReceivedInvocations: [UIImage] = []
    public var uploadImageReturnValue: CurrentValueSubject<Bool, Error>!
    public var uploadImageClosure: ((UIImage) -> CurrentValueSubject<Bool, Error>)?

    public func upload(image: UIImage) -> CurrentValueSubject<Bool, Error> {
        uploadImageCallsCount += 1
        uploadImageReceivedImage = image
        uploadImageReceivedInvocations.append(image)
        if let uploadImageClosure = uploadImageClosure {
            return uploadImageClosure(image)
        } else {
            return uploadImageReturnValue
        }
    }
}
