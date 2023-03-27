import Combine

final class UserDataServiceMock: ObservableObject, UserDataServiceInput {
    var user = CurrentValueSubject<User?, Never>(nil)
    var searchedUsers = CurrentValueSubject<[User], Never>([])
    var searchedOtherMembers = CurrentValueSubject<[User], Never>([])
    var searchedFriendMembers = CurrentValueSubject<[User], Never>([])
    var eventMembers = CurrentValueSubject<[User], Never>([])

    func resetUser() {}

    func createUserDocument(with id: String, name: String) -> CurrentValueSubject<Bool, Error> {
        CurrentValueSubject<Bool, Error>(false)
    }

    func getUserData(for id: String) {}

    func updateUserName(to name: String) {}

    func fetchUsers(containing substring: String) {}

    func fetchSearchedUsers(containing substring: String, isInitialFetch: Bool, filtering: [User]) {}

    func addFriend(_ friend: User) {}

    func fetchMembers(_ ids: [String]) {}
}
