public struct User: Identifiable {
    public var id: String
    public var name: String
    public var photo: String
    public var friends: [String]
    public var events: [String]

    init(
        id: String,
        name: String,
        photo: String = .empty,
        friends: [String] = [],
        events: [String] = []
    ) {
        self.id = id
        self.name = name
        self.photo = photo
        self.friends = friends
        self.events = events
    }
}

extension User {
    var defaultDocumentValue: [String: Any] {
        [
            "id": id,
            "name": name,
            "photo": photo,
            "friends": [],
            "events": []
        ]
    }
}
