import Combine
import FirebaseFirestore

public protocol EventDataServiceInput {
    var userEvents: CurrentValueSubject<[Event], Never> { get }

    func getEvents(for user: User)
    func createEvent(_ event: Event)
}

public final class EventDataService {
    private typealias Keys = Txt.EventData
    private let eventCollection = Firestore.firestore().collection(Keys.eventCollection)

    public var userEvents = CurrentValueSubject<[Event], Never>([])
}

extension EventDataService: EventDataServiceInput {
    public func getEvents(for user: User) {
        var events: [Event] = []

        let query = user.events.isEmpty ? eventCollection.whereField(Keys.id, isEqualTo: user.id) : eventCollection.whereField(Keys.id, in: user.events)

        query
            .addSnapshotListener { query, error in
                if error == nil, let documents = query?.documents {
                    events.removeAll()
                    for document in documents {
                        if let event = Event(fromDocument: document.data()) {
                            events.append(event)
                        }
                    }
                    self.userEvents.send(events)
                }
            }
    }

    public func createEvent(_ event: Event) {
        eventCollection
            .document(event.id)
            .setData(event.defaultDocumentValue) { error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    // TODO: Add event to users
                }
            }
    }
}
