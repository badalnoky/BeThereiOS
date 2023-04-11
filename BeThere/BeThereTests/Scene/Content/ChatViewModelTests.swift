@testable import BeThere
import Combine
import XCTest

// swiftlint:disable: implicitly_unwrapped_optional
final class ChatViewModelTests: XCTestCase {
    private var sut: ChatViewModel!
    private var userService: UserDataServiceInputMock!
    private var eventService: EventDataServiceInputMock!

    private let userTestMock = User(
        id: "messageSentBy",
        name: "testName",
        photo: "testUrl",
        friends: [],
        events: []
    )

    override func setUpWithError() throws {
        try super.setUpWithError()

        userService = .init()
        eventService = .init()

        eventService.currentEvent = CurrentValueSubject<Event, Never>(.mock)
        userService.eventMembers = CurrentValueSubject<[User], Never>([.mock, userTestMock])
        userService.user = CurrentValueSubject<User?, Never>(User.mock)

        sut = .init(
            navigator: .init(sceneFactory: ContentSceneFactory(), root: .main),
            eventService: eventService,
            userDataService: userService,
            eventId: "testId"
        )
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()

        sut = nil

        userService = nil
        eventService = nil
    }

    func test_init_shouldRegisterBindings() throws {
        XCTAssertEqual(sut.event, .mock)
        XCTAssertTrue(userService.fetchMembersCalled)
        XCTAssertEqual(userService.fetchMembersCallsCount, 1)
        XCTAssertEqual(sut.members, [.mock, userTestMock])
        XCTAssertEqual(sut.urlCatalog.count, 2)
    }

    func test_didTapSend_shouldInvokeSend() throws {
        sut.currentMessage = "testMessage"

        sut.didTapSend()

        XCTAssertTrue(eventService.sendToCalled)
        XCTAssertEqual(eventService.sendToCallsCount, 1)
    }

    func test_getMessageSettings_shouldReturnMessageSettings() throws {
        let result = sut.getMessageSettings(indexed: 0)

        XCTAssertEqual(result, MessageSettings(sentByUser: false, isContinued: false))
    }
}
