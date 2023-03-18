import Combine
import FirebaseAuth
import FirebaseFirestore

public protocol AuthenticationServiceInput {
    func signIn(email: String, password: String) -> CurrentValueSubject<Bool, Error>
    func registrate(email: String, password: String, name: String) -> CurrentValueSubject<Bool, Error>
    func signOut() -> CurrentValueSubject<Bool, Error>
}

final class AuthenticatonService: ObservableObject {
    private typealias Str = Txt.Authentication
    private let authenticator = Auth.auth()
    private let userCollection = Firestore.firestore().collection(Str.userCollectionKey)
    private var cancellables = Set<AnyCancellable>()
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
        authenticator.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            if let error = error {
                loggedIn.send(completion: .failure(error))
            } else if let result = result {
                self.createUserDocument(with: result.user.uid, name: name)
                    .sink(
                        receiveValue: { if $0 { loggedIn.send(true) } },
                        receiveError: { print($0) }
                    )
                    .store(in: &self.cancellables)
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

private extension AuthenticatonService {
    func createUserDocument(with id: String, name: String) -> CurrentValueSubject<Bool, Error> {
        let created = CurrentValueSubject<Bool, Error>(false)

        let user = User(id: id, name: name)
        userCollection
            .document(id)
            .setData(user.defaultDocumentValue) { error in
                if let error = error {
                    created.send(completion: .failure(error))
                } else {
                    created.send(true)
                }
            }

        return created
    }
}
