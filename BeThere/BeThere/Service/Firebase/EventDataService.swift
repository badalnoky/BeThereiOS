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
    private let userCollection = Firestore.firestore().collection(Keys.userCollection)

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
            .setData(event.defaultDocumentValue) { [weak self] error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    self?.addEvent(to: event.users, eventId: event.id)
                }
            }
    }
}

private extension EventDataService {
    func addEvent(to usersIds: [String], eventId: String) {
        let batch = Firestore.firestore().batch()

        for id in usersIds {
            batch.updateData([Keys.events: FieldValue.arrayUnion([eventId])], forDocument: userCollection.document(id))
        }

        batch.commit { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
