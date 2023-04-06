@testable import BeThere
import Combine
import XCTest

// swiftlint:disable: implicitly_unwrapped_optional
final class EventViewModelTests: XCTestCase {
    private var sutCreation: EventViewModel!
    private var sutModification: EventViewModel!
    private var userService: UserDataServiceInputMock!
    private var eventService: EventDataServiceInputMock!

    private let userTestMock = User(
        id: "testId",
        name: "testName",
        photo: "testUrl",
        friends: [],
        events: []
    )

    override func setUpWithError() throws {
        try super.setUpWithError()

        userService = .init()
        eventService = .init()

        userService.user = CurrentValueSubject<User?, Never>(User.mock)
        userService.eventMembers = CurrentValueSubject<[User], Never>([.mock, userTestMock])
        eventService.currentEvent = CurrentValueSubject<Event, Never>(.mock)
        eventService.provisionalMembers = CurrentValueSubject<[User], Never>([])

        sutCreation = .init(
            navigator: .init(sceneFactory: ContentSceneFactory(), root: .main),
            eventService: eventService,
            userDataService: userService
        )

        sutModification = .init(
            navigator: .init(sceneFactory: ContentSceneFactory(), root: .main),
            eventService: eventService,
            userDataService: userService,
            eventId: "testId"
        )
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()

        sutModification = nil
        sutCreation = nil

        userService = nil
        eventService = nil
    }

    func test_initCreation_shouldRegisterBindings() throws {
        XCTAssertEqual(sutCreation.members, [User.mock])
    }

    func test_initModification_shouldRegisterBindings() throws {
        XCTAssertEqual(sutModification.name, Event.mock.name)
        XCTAssertEqual(sutModification.date, Event.mock.date)
        XCTAssertEqual(sutModification.location, Event.mock.location)
        XCTAssertEqual(sutModification.members, [.mock, userTestMock])
    }

    func test_didTapSaveCreation_shouldInvokeCreate() throws {
        sutCreation.name = "testName"
        sutCreation.location = "testLocation"

        sutCreation.didTapSave()

        XCTAssertTrue(eventService.createEventCalled)
        XCTAssertEqual(eventService.createEventCallsCount, 1)
    }

    func test_didTapSaveModification_shouldInvokeUpdate() throws {
        eventService.updateEventWithDifferenceReturnValue = CurrentValueSubject(true)

        sutModification.didTapSave()

        XCTAssertTrue(eventService.updateEventWithDifferenceCalled)
        XCTAssertEqual(eventService.updateEventWithDifferenceCallsCount, 1)
    }

    func test_setChoosingDate_shouldSetIsChoosingDate() throws {
        sutCreation.setChoosingDate()

        XCTAssertTrue(sutCreation.isChoosingDate)
    }
}
