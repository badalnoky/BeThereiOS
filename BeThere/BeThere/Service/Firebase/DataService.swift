import Combine
import FirebaseFirestore

public protocol DataServiceInput {
    var user: CurrentValueSubject<User?, Never> { get }

    func resetUser()
    func getUserData(for id: String)
    func createUserDocument(with id: String, name: String) -> CurrentValueSubject<Bool, Error>
}

public final class DataService {
    private typealias Keys = Txt.Data
    private let userCollection = Firestore.firestore().collection(Keys.userCollectionKey)

    public var user = CurrentValueSubject<User?, Never>(nil)
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
}
