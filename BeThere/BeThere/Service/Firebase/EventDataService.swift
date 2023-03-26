import Combine
import FirebaseFirestore

public protocol EventDataServiceInput {
    var userEvents: CurrentValueSubject<[Event], Never> { get }
    var currentEvent: CurrentValueSubject<Event, Never> { get }
    var provisionalMembers: CurrentValueSubject<[User], Never> { get }

    func getEvents(for user: User)
    func createEvent(_ event: Event)
    func updateEvent(with id: String, difference: [String: Any]) -> CurrentValueSubject<Bool, Never>
    func getEventData(for id: String)
    func provisionallyAdd(user: User)
}

public final class EventDataService {
    private typealias Keys = Txt.EventData
    private let eventCollection = Firestore.firestore().collection(Keys.eventCollection)
    private let userCollection = Firestore.firestore().collection(Keys.userCollection)

    public var userEvents = CurrentValueSubject<[Event], Never>([])
    public var currentEvent = CurrentValueSubject<Event, Never>(.mock)
    public var provisionalMembers = CurrentValueSubject<[User], Never>([])
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
                    self?.provisionalMembers.send([])
                }
            }
    }

    public func updateEvent(with id: String, difference: [String: Any]) -> CurrentValueSubject<Bool, Never> {
        let successfulUpdate = CurrentValueSubject<Bool, Never>(false)

        eventCollection
            .document(id)
            .updateData(difference) { [weak self] error in
                guard error == nil else { return }
                self?.provisionalMembers.send([])
            }

        return successfulUpdate
    }

    public func getEventData(for id: String) {
        eventCollection
            .document(id)
            .addSnapshotListener { [weak self] documentSnapshot, error in
                guard let document = documentSnapshot else { return }
                guard let data = document.data() else { return }
                guard let event = Event(fromDocument: data) else { return }
                self?.currentEvent.send(event)
            }
    }

    public func provisionallyAdd(user: User) {
        let newArray = provisionalMembers.value + [user]
        provisionalMembers.send(newArray)
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
