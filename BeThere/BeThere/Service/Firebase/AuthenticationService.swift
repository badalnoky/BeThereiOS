import Combine
import FirebaseAuth

public protocol AuthenticationServiceInput {
    func signIn(email: String, password: String) -> CurrentValueSubject<Bool, Error>
    func registrate(email: String, password: String, name: String) -> CurrentValueSubject<Bool, Error>
    func signOut() -> CurrentValueSubject<Bool, Error>
}

final class AuthenticatonService: ObservableObject {
    private let authenticator = Auth.auth()
}

extension AuthenticatonService: AuthenticationServiceInput {
    public func signIn(email: String, password: String) -> CurrentValueSubject<Bool, Error> {
        let loggedIn = CurrentValueSubject<Bool, Error>(false)
        authenticator.signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                loggedIn.send(completion: .failure(error))
            } else if result != nil {
                loggedIn.send(true)
            }
        }
        return loggedIn
    }

    public func registrate(email: String, password: String, name: String) -> CurrentValueSubject<Bool, Error> {
        let loggedIn = CurrentValueSubject<Bool, Error>(false)
        authenticator.createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                loggedIn.send(completion: .failure(error))
            } else if result != nil {
                loggedIn.send(true)
            }
        }
        return loggedIn
    }

    public func signOut() -> CurrentValueSubject<Bool, Error> {
        let successfulSignOut = CurrentValueSubject<Bool, Error>(false)
        do {
            try authenticator.signOut()
            successfulSignOut.send(true)
        } catch {
            successfulSignOut.send(completion: .failure(error))
        }
        return successfulSignOut
    }
}
