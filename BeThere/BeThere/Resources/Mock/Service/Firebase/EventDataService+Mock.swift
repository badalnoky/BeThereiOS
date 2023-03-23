import Combine

final class EventDataServiceMock: EventDataServiceInput {
    var userEvents = CurrentValueSubject<[Event], Never>([])
    var currentEvent = CurrentValueSubject<Event, Never>(.mock)

    func getEvents(for user: User) {}
    func createEvent(_ event: Event) {}
    func getEventData(for id: String) {}
}
