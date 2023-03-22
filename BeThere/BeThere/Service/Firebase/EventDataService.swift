import Combine
import FirebaseFirestore

public protocol EventDataServiceInput {
    var events: CurrentValueSubject<[Event], Never> { get }

    func getEvents(for user: User)
}

public final class EventDataService {
    private typealias Keys = Txt.EventData
    private let eventCollecion = Firestore.firestore().collection(Keys.eventCollection)

    public var events = CurrentValueSubject<[Event], Never>([])
}

extension EventDataService: EventDataServiceInput {
    public func getEvents(for user: User) {
        var events: [Event] = []

        let query = user.events.isEmpty ? eventCollecion.whereField(Keys.id, isEqualTo: user.id) : eventCollecion.whereField(Keys.id, in: user.events)

        query
            .addSnapshotListener { query, error in
                if error == nil, let documents = query?.documents {
                    events.removeAll()
                    for document in documents {
                        if let event = Event(fromDocument: document.data()) {
                            events.append(event)
                        }
                    }
                    self.events.send(events)
                }
            }
    }
}
