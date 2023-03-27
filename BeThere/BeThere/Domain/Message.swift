public struct Message {
    public var id: String
    public var sentBy: String
    public var text: String

    init(
        id: String,
        sentBy: String,
        text: String
    ) {
        self.id = id
        self.sentBy = sentBy
        self.text = text
    }
}

extension Message {
    private typealias Keys = Txt.Message

    var defaultDocumentValue: [String: Any] {
        [
            Keys.id: id,
            Keys.sentBy: sentBy,
            Keys.text: text
        ]
    }

    init?(fromDocument data: [String: Any]) {
        guard let id = data[Keys.id] as? String else { return nil }
        guard let sentBy = data[Keys.sentBy] as? String else { return nil }
        guard let text = data[Keys.text] as? String else { return nil }

        self.id = id
        self.sentBy = sentBy
        self.text = text
    }

    static func fromDocument(_ data: [[String: Any]]) -> [Message] {
        var messages: [Message] = []
        for document in data {
            if let message = Message(fromDocument: document) {
                messages.append(message)
            }
        }

        return messages
    }
}
