@testable import BeThere
import Combine
import XCTest

// swiftlint:disable: implicitly_unwrapped_optional
final class AddMemberViewModelTests: XCTestCase {
    private var sut: AddMemberViewModel!
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

        userService.searchedFriendMembers = CurrentValueSubject<[User], Never>([userTestMock])
        userService.searchedOtherMembers = CurrentValueSubject<[User], Never>([.mock])
        eventService.provisionalMembers = CurrentValueSubject<[User], Never>([])

        sut = .init(
            navigator: .init(sceneFactory: ContentSceneFactory(), root: .main),
            userDataService: userService,
            eventService: eventService,
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
        XCTAssertEqual(sut.friends, [userTestMock])
        XCTAssertEqual(sut.otherUsers, [.mock])
    }

    func test_didTapSearch_shouldInvokeFetch() throws {
        sut.searchString = "testString"

        XCTAssertTrue(userService.fetchSearchedUsersContainingIsInitialFetchFilteringCalled)
        XCTAssertEqual(userService.fetchSearchedUsersContainingIsInitialFetchFilteringCallsCount, 2)
    }

    func test_didTapAdd_shouldInvokeprovisionallyAddAndFetch() throws {
        sut.didTapAdd(user: .mock)

        XCTAssertTrue(userService.fetchSearchedUsersContainingIsInitialFetchFilteringCalled)
        XCTAssertEqual(userService.fetchSearchedUsersContainingIsInitialFetchFilteringCallsCount, 2)
        XCTAssertTrue(eventService.provisionallyAddUserCalled)
        XCTAssertEqual(eventService.provisionallyAddUserCallsCount, 1)
    }
}
