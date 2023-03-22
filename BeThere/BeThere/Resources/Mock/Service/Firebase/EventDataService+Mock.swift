import Combine

final class EventDataServiceMock: EventDataServiceInput {
    var userEvents = CurrentValueSubject<[Event], Never>([])

    func getEvents(for user: User) {}
    func createEvent(_ event: Event) {}
}
