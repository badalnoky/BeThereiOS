import Combine
import FirebaseFirestore

public protocol UserDataServiceInput {
    var user: CurrentValueSubject<User?, Never> { get }
    var foundUsers: CurrentValueSubject<[User], Never> { get }
    var foundFriends: CurrentValueSubject<[User], Never> { get }
    var eventMembers: CurrentValueSubject<[User], Never> { get }

    func resetUser()
    func getUserData(for id: String)
    func createUserDocument(with id: String, name: String) -> CurrentValueSubject<Bool, Error>
    func updateUserName(to name: String)
    func fetchUsers(containing substring: String, searchForFriends: Bool)
    func addFriend(_ friend: User)
    func fetchMembers(_ ids: [String])
}

public final class UserDataService {
    private typealias Keys = Txt.Data
    private let userCollection = Firestore.firestore().collection(Keys.userCollection)

    public var user = CurrentValueSubject<User?, Never>(nil)
    public var foundUsers = CurrentValueSubject<[User], Never>([])
    public var foundFriends = CurrentValueSubject<[User], Never>([])
    public var eventMembers = CurrentValueSubject<[User], Never>([])
}

extension UserDataService: UserDataServiceInput {
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

    public func fetchUsers(containing substring: String, searchForFriends: Bool) {
        guard let user = self.user.value else { return }

        var otherUsers: [User] = []
        var friends: [User] = []

        let withoutFriendsArray = user.friends.isEmpty ? [user.id] : user.friends + [user.id]
        let filter = searchForFriends ? [user.id] : withoutFriendsArray

        userCollection
            .whereField(Keys.id, notIn: filter)
            .addSnapshotListener { [weak self] query, error in
                if error == nil, let documents = query?.documents {
                    otherUsers.removeAll()
                    friends.removeAll()
                    for document in documents {
                        if let addedUser = User(fromDocument: document.data()), addedUser.name.contains(substring) {
                            if searchForFriends, user.friends.contains(addedUser.id) {
                                friends.append(addedUser)
                            } else {
                                otherUsers.append(addedUser)
                            }
                        }
                    }
                    self?.foundUsers.send(otherUsers)
                    if searchForFriends {
                        self?.foundFriends.send(friends)
                    }
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

    public func fetchMembers(_ ids: [String]) {
        guard !ids.isEmpty else { return }
        var users: [User] = []

        userCollection
            .whereField(Keys.id, in: ids)
            .addSnapshotListener { [weak self] query, error in
                if error == nil, let documents = query?.documents {
                    users.removeAll()
                    for document in documents {
                        if let user = User(fromDocument: document.data()) {
                            users.append(user)
                        }
                    }
                    self?.eventMembers.send(users)
                }
            }
    }
}
