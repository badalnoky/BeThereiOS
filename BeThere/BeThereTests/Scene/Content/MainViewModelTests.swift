@testable import BeThere
import Combine
import XCTest

// swiftlint:disable: implicitly_unwrapped_optional
final class MainViewModelTests: XCTestCase {
    private var sut: MainViewModel!
    private var authenticationService: AuthenticationServiceInputMock!
    private var userService: UserDataServiceInputMock!
    private var eventService: EventDataServiceInputMock!

    private let eventTestMock = Event(
        id: "testId",
        name: "testName",
        location: "testLocation",
        date: .defaultDateTime,
        users: [],
        messages: []
    )

    override func setUpWithError() throws {
        try super.setUpWithError()

        authenticationService = .init()
        userService = .init()
        eventService = .init()

        userService.user = CurrentValueSubject<User?, Never>(User.mock)
        eventService.userEvents = CurrentValueSubject<[Event], Never>([.mock, eventTestMock])

        sut = .init(
            navigator: .init(sceneFactory: ContentSceneFactory(), root: .main),
            authenticationService: authenticationService,
            userDataService: userService,
            eventService: eventService
        )
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()

        sut = nil

        authenticationService = nil
        userService = nil
        eventService = nil
    }

    func test_init_shouldRegisterBindings() throws {
        XCTAssertEqual(sut.filteredEvents, [.mock, eventTestMock])
    }

    func test_didTapSignOut_shouldInvokeSingOut() throws {
        authenticationService.signOutReturnValue = CurrentValueSubject(true)

        sut.didTapSignOut()

        XCTAssertTrue(authenticationService.signOutCalled)
        XCTAssertEqual(authenticationService.signOutCallsCount, 1)
    }

    func test_didTapSearch_shouldFilterEvents() throws {
        sut.searchString = "test"
        sut.didTapSearch()
        XCTAssertEqual(sut.filteredEvents, [eventTestMock])
    }
}
