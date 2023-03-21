import Combine

final class DataServiceMock: ObservableObject, DataServiceInput {
    var user = CurrentValueSubject<User?, Never>(nil)
    var foundUsers = CurrentValueSubject<[User], Never>([])

    func resetUser() {}

    func getUserData(for id: String) {}

    func createUserDocument(with id: String, name: String) -> CurrentValueSubject<Bool, Error> {
        CurrentValueSubject<Bool, Error>(false)
    }

    func updateUserName(to name: String) {}

    func fetchUsers(containing substring: String) {}
}
