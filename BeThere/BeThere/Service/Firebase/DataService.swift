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
    func addFriend(_ friend: User)
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
        let filterArray = user.friends.isEmpty ? [user.id] : user.friends + [user.id]

        userCollection
            .whereField(Keys.id, notIn: filterArray)
            .getDocuments { [weak self] query, error in
                if error == nil, let documents = query?.documents {
                    for document in documents {
                        if let addedUser = User(fromDocument: document.data()), addedUser.name.contains(substring) {
                            users.append(addedUser)
                        }
                    }
                    self?.foundUsers.send(users)
                }
            }
    }

    public func addFriend(_ friend: User) {
        guard let user = self.user.value else { return }

        userCollection
            .document(user.id)
            .updateData([Keys.friends: FieldValue.arrayUnion([friend.id])]) { [weak self] error in
                guard error == nil, var updatedUsers = self?.foundUsers.value else { return }
                updatedUsers.removeAll { $0.id == friend.id }
                self?.foundUsers.send(updatedUsers)
            }
    }
}
