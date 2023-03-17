import Combine
final class AuthenticatonServiceMock: ObservableObject, AuthenticationServiceInput {
    func signIn(email: String, password: String) -> CurrentValueSubject<Bool, Error> {
        CurrentValueSubject<Bool, Error>(false)
    }

    func registrate(email: String, password: String, name: String) -> CurrentValueSubject<Bool, Error> {
        CurrentValueSubject<Bool, Error>(false)
    }

    func signOut() -> CurrentValueSubject<Bool, Error> {
        CurrentValueSubject<Bool, Error>(false)
    }
}
