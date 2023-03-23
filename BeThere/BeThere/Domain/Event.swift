import FirebaseFirestore
import Foundation

public struct Event: Identifiable {
    public var id: String
    public var name: String
    public var location: String
    public var date: Date
    public var users: [String]
    public var messages: [Message]

    init(
        id: String,
        name: String,
        location: String,
        date: Date,
        users: [String],
        messages: [Message]
    ) {
        self.id = id
        self.name = name
        self.location = location
        self.date = date
        self.users = users
        self.messages = messages
    }
}

extension Event {
    private typealias Keys = Txt.Event

    static var mock: Event {
        Event(id: .empty, name: .empty, location: .empty, date: .now, users: [], messages: [])
    }

    var defaultDocumentValue: [String: Any] {
        [
            Keys.id: id,
            Keys.name: name,
            Keys.location: location,
            Keys.date: date,
            Keys.users: users,
            Keys.messages: []
        ]
    }

    init?(fromDocument data: [String: Any]) {
        guard let id = data[Keys.id] as? String else { return nil }
        guard let name = data[Keys.name] as? String else { return nil }
        guard let location = data[Keys.location] as? String else { return nil }
        guard let date = data[Keys.date] as? Timestamp else { return nil }
        guard let users = data[Keys.users] as? [String] else { return nil }
        guard let wrappedMessages = data[Keys.messages] as? [[String: Any]] else { return nil }

        self.id = id
        self.name = name
        self.location = location
        self.date = date.dateValue()
        self.users = users
        self.messages = Message.fromDocument(wrappedMessages)
    }
}
