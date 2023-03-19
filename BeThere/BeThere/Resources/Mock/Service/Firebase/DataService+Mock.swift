import Combine

final class DataServiceMock: ObservableObject, DataServiceInput {
    var user = CurrentValueSubject<User?, Never>(nil)

    func resetUser() {}

    func getUserData(for id: String) {}

    func createUserDocument(with id: String, name: String) -> CurrentValueSubject<Bool, Error> {
        CurrentValueSubject<Bool, Error>(false)
    }
}
