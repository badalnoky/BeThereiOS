import Combine

final class EventDataServiceMock: EventDataServiceInput {
    var events = CurrentValueSubject<[Event], Never>([])

    func getEvents(_ id: [String]) {}
}
