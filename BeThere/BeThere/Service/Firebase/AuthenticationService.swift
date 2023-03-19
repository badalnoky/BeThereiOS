import Combine
import FirebaseAuth
import FirebaseFirestore

public protocol AuthenticationServiceInput {
    var user: CurrentValueSubject<User?, Never> { get }

    func signIn(email: String, password: String) -> CurrentValueSubject<Bool, Error>
    func registrate(email: String, password: String, name: String) -> CurrentValueSubject<Bool, Error>
    func signOut() -> CurrentValueSubject<Bool, Error>
}

public final class AuthenticatonService: ObservableObject {
    private typealias Keys = Txt.Authentication
    private let authenticator = Auth.auth()
    private let userCollection = Firestore.firestore().collection(Keys.userCollectionKey)
    private var cancellables = Set<AnyCancellable>()

    public var user = CurrentValueSubject<User?, Never>(nil)
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
                        receiveValue: {
                            if $0 {
                                self.getUserData(for: result.user.uid)
                                loggedIn.send(true)
                            }
                        },
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

    func getUserData(for id: String) {
        userCollection
            .document(id)
            .addSnapshotListener { [weak self] documentSnapshot, error in
                guard let document = documentSnapshot else { return }
                guard let data = document.data() else { return }
                guard let user = User(fromDocument: data) else { return }
                self?.user.send(user)
            }
    }
}
