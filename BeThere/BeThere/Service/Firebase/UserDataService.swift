import Combine
import FirebaseFirestore
import FirebaseStorage

// sourcery: AutoMockable
public protocol UserDataServiceInput {
    var user: CurrentValueSubject<User?, Never> { get }
    var searchedUsers: CurrentValueSubject<[User], Never> { get }
    var searchedOtherMembers: CurrentValueSubject<[User], Never> { get }
    var searchedFriendMembers: CurrentValueSubject<[User], Never> { get }
    var eventMembers: CurrentValueSubject<[User], Never> { get }

    func resetUser()
    func createUserDocument(with id: String, name: String) -> CurrentValueSubject<Bool, Error>
    func getUserData(for id: String)
    func updateUserName(to name: String)
    func fetchUsers(containing substring: String)
    func fetchSearchedUsers(containing substring: String, isInitialFetch: Bool, filtering: [User])
    func addFriend(_ friend: User)
    func fetchMembers(_ ids: [String])
    func upload(image: UIImage) -> CurrentValueSubject<Bool, Error>
}

public final class UserDataService {
    private typealias Keys = Txt.Data
    private let userCollection = Firestore.firestore().collection(Keys.userCollection)
    private let folderReference = Storage.storage().reference().child(Keys.defaultImagePath)

    public var user = CurrentValueSubject<User?, Never>(nil)
    public var searchedUsers = CurrentValueSubject<[User], Never>([])
    public var searchedOtherMembers = CurrentValueSubject<[User], Never>([])
    public var searchedFriendMembers = CurrentValueSubject<[User], Never>([])
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

    public func fetchUsers(containing substring: String) {
        guard let user = self.user.value else { return }

        var otherUsers: [User] = []
        let filter = user.friends.isEmpty ? [user.id] : user.friends + [user.id]

        userCollection
            .whereField(Keys.id, notIn: filter)
            .addSnapshotListener { [weak self] query, error in
                if error == nil, let documents = query?.documents {
                    otherUsers.removeAll()
                    for document in documents {
                        if let addedUser = User(fromDocument: document.data()), addedUser.name.caseInsensitiveContains(substring) {
                            otherUsers.append(addedUser)
                        }
                    }
                    self?.searchedUsers.send(otherUsers)
                }
            }
    }

    public func fetchSearchedUsers(containing substring: String, isInitialFetch: Bool, filtering: [User]) {
        guard let user = self.user.value else { return }

        var otherUsers: [User] = []
        var friends: [User] = []

        let filter = [user.id] + eventMembers.value.map { $0.id } + filtering.map { $0.id }

        userCollection
            .whereField(Keys.id, notIn: filter)
            .addSnapshotListener { [weak self] query, error in
                if error == nil, let documents = query?.documents {
                    otherUsers.removeAll()
                    friends.removeAll()
                    for document in documents {
                        if let addedUser = User(fromDocument: document.data()) {
                            if (isInitialFetch || addedUser.name.caseInsensitiveContains(substring)) && user.friends.contains(addedUser.id) {
                                friends.append(addedUser)
                            } else if !isInitialFetch, !user.friends.contains(addedUser.id), addedUser.name.caseInsensitiveContains(substring) {
                                otherUsers.append(addedUser)
                            }
                        }
                    }
                    self?.searchedOtherMembers.send(otherUsers)
                    self?.searchedFriendMembers.send(friends)
                }
            }
    }

    public func addFriend(_ friend: User) {
        guard let user = self.user.value else { return }

        userCollection
            .document(user.id)
            .updateData([Keys.friends: FieldValue.arrayUnion([friend.id])]) { [weak self] error in
                guard error == nil, var updatedUsers = self?.searchedUsers.value else { return }
                updatedUsers.removeAll { $0.id == friend.id }
                self?.searchedUsers.send(updatedUsers)
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

    public func upload(image: UIImage) -> CurrentValueSubject<Bool, Error> {
        let successfullUpload = CurrentValueSubject<Bool, Error>(false)
        guard let user = self.user.value else { return successfullUpload }
        guard let data = image.jpegData(compressionQuality: .defaultCompressionQuality) else { return successfullUpload }
        let imageReference = folderReference.child(user.id)
        let metadata = StorageMetadata()
        metadata.contentType = Keys.defaultImageType

        imageReference.putData(data, metadata: metadata) { metadata, error in
            guard error == nil else { return }

            imageReference.downloadURL { [weak self] url, error in
                guard error == nil else { return }
                if let url = url {
                    self?.updateUrlOf(url: url.absoluteString, completion: successfullUpload)
                }
            }
        }

        return successfullUpload
    }
}

private extension UserDataService {
    func updateUrlOf(url: String, completion: CurrentValueSubject<Bool, Error>) {
        guard let user = self.user.value else { return }

        userCollection
            .document(user.id)
            .updateData([Keys.photo: url]) { error in
                guard error == nil else { return }
                completion.send(true)
            }
    }
}
