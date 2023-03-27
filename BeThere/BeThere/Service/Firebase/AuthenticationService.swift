import Combine
import FirebaseAuth

public protocol AuthenticationServiceInput {
    func signIn(email: String, password: String) -> CurrentValueSubject<Bool, Error>
    func registrate(email: String, password: String, name: String) -> CurrentValueSubject<Bool, Error>
    func signOut() -> CurrentValueSubject<Bool, Error>
}

public final class AuthenticatonService: ObservableObject {
    private let authenticator = Auth.auth()
    private var cancellables = Set<AnyCancellable>()
    private var userDataService: UserDataServiceInput

    init(userDataService: UserDataServiceInput) {
        self.userDataService = userDataService
    }
}

extension AuthenticatonService: AuthenticationServiceInput {
    public func signIn(email: String, password: String) -> CurrentValueSubject<Bool, Error> {
        let loggedIn = CurrentValueSubject<Bool, Error>(false)
        authenticator.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            if let error = error {
                loggedIn.send(completion: .failure(error))
            } else if let result = result {
                self.userDataService.getUserData(for: result.user.uid)
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
                self.userDataService.createUserDocument(with: result.user.uid, name: name)
                    .sink(
                        receiveValue: {
                            if $0 {
                                self.userDataService.getUserData(for: result.user.uid)
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
            self.userDataService.resetUser()
            successfulSignOut.send(true)
        } catch {
            successfulSignOut.send(completion: .failure(error))
        }
        return successfulSignOut
    }
}
