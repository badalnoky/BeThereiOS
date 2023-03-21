import Combine
import FirebaseFirestore

public protocol EventDataServiceInput {
    var events: CurrentValueSubject<[Event], Never> { get }

    func getEvents(_ id: [String])
}

public final class EventDataService {
    private typealias Keys = Txt.EventData
    private let eventCollecion = Firestore.firestore().collection(Keys.eventCollection)

    public var events = CurrentValueSubject<[Event], Never>([])
}

extension EventDataService: EventDataServiceInput {
    public func getEvents(_ ids: [String]) {
        var events: [Event] = []

        eventCollecion
            .whereField(Keys.id, in: ids)
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
