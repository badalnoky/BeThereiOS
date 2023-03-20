import Combine
import FirebaseFirestore

public protocol DataServiceInput {
    var user: CurrentValueSubject<User?, Never> { get }
    var foundUsers: CurrentValueSubject<[User], Never> { get }

    func resetUser()
    func getUserData(for id: String)
    func createUserDocument(with id: String, name: String) -> CurrentValueSubject<Bool, Error>
    func updateUserName(to name: String)
    func fetchUsers(containing substring: String)
}

public final class DataService {
    private typealias Keys = Txt.Data
    private let userCollection = Firestore.firestore().collection(Keys.userCollection)

    public var user = CurrentValueSubject<User?, Never>(nil)
    public var foundUsers = CurrentValueSubject<[User], Never>([])
}

extension DataService: DataServiceInput {
    public func resetUser() {
        user.value = nil
    }

    public func createUserDocument(with id: String, name: String) -> CurrentValueSubject<Bool, Error> {
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

    public func getUserData(for id: String) {
        userCollection
            .document(id)
            .addSnapshotListener { [weak self] documentSnapshot, error in
                guard let document = documentSnapshot else { return }
                guard let data = document.data() else { return }
                guard let user = User(fromDocument: data) else { return }
                self?.user.send(user)
            }
    }

    public func updateUserName(to name: String) {
        guard let user = self.user.value else { return }
        userCollection
            .document(user.id)
            .updateData([Keys.name: name]) { error in
                guard error == nil else { return }
            }
    }

    public func fetchUsers(containing substring: String) {
        guard let user = self.user.value else { return }

        var users: [User] = []
        var query = userCollection.whereField(Keys.id, isNotEqualTo: user.id)
        if !user.friends.isEmpty { query = query.whereField(Keys.id, notIn: user.friends) }

        query
            .getDocuments { [weak self] query, error in
                guard error == nil else { return }
                if let documents = query?.documents {
                    for document in documents {
                        if let user = User(fromDocument: document.data()), user.name.contains(substring) {
                            users.append(user)
                        }
                    }
                    self?.foundUsers.send(users)
                }
            }
    }
}
