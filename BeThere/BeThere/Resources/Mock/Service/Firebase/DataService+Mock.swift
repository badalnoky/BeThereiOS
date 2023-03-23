import Combine

final class UserDataServiceMock: ObservableObject, UserDataServiceInput {
    var user = CurrentValueSubject<User?, Never>(nil)
    var foundUsers = CurrentValueSubject<[User], Never>([])
    var foundFriends = CurrentValueSubject<[User], Never>([])
    var eventMembers = CurrentValueSubject<[User], Never>([])

    func resetUser() {}

    func getUserData(for id: String) {}

    func createUserDocument(with id: String, name: String) -> CurrentValueSubject<Bool, Error> {
        CurrentValueSubject<Bool, Error>(false)
    }

    func updateUserName(to name: String) {}

    func fetchUsers(containing substring: String, searchForFriends: Bool) {}

    func addFriend(_ friend: User) {}

    func fetchMembers(_ ids: [String]) {}
}
