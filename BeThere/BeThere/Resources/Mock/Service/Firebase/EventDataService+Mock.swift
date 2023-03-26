import Combine

final class EventDataServiceMock: EventDataServiceInput {
    var userEvents = CurrentValueSubject<[Event], Never>([])
    var currentEvent = CurrentValueSubject<Event, Never>(.mock)
    var provisionalMembers = CurrentValueSubject<[User], Never>([])

    func getEvents(for user: User) {}
    func createEvent(_ event: Event) {}

    func updateEvent(with id: String, difference: [String: Any]) -> CurrentValueSubject<Bool, Never> {
        CurrentValueSubject<Bool, Never>(false)
    }

    func getEventData(for id: String) {}

    func provisionallyAdd(user: User) {}
}
