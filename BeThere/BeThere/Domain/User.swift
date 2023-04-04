public struct User: Identifiable, Equatable {
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
    private typealias Keys = Txt.User

    static var mock: User {
        User(
            id: Keys.Mock.id,
            name: Keys.Mock.name,
            photo: Keys.Mock.photo,
            friends: [],
            events: []
        )
    }

    var defaultDocumentValue: [String: Any] {
        [
            Keys.id: id,
            Keys.name: name,
            Keys.photo: photo,
            Keys.friends: [],
            Keys.events: []
        ]
    }

    init?(fromDocument data: [String: Any]) {
        guard let id = data[Keys.id] as? String else { return nil }
        guard let name = data[Keys.name] as? String else { return nil }
        guard let photo = data[Keys.photo] as? String else { return nil }
        guard let friends = data[Keys.friends] as? [String] else { return nil }
        guard let events = data[Keys.events] as? [String] else { return nil }

        self.id = id
        self.name = name
        self.photo = photo
        self.friends = friends
        self.events = events
    }
}
