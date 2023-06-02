@testable import BeThere
import Combine
import XCTest

// swiftlint:disable: implicitly_unwrapped_optional
final class SearchViewModelTests: XCTestCase {
    private var sut: SearchViewModel!
    private var userService: UserDataServiceInputMock!

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

        userService.searchedUsers = CurrentValueSubject<[User], Never>([User.mock, userTestMock])

        sut = .init(
            navigator: .init(sceneFactory: ContentSceneFactory(), root: .main),
            userDataService: userService
        )
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()

        sut = nil

        userService = nil
    }

    func test_init_shouldRegisterBindings() throws {
        XCTAssertEqual(sut.otherUsers, [User.mock, userTestMock])
        XCTAssertEqual(userService.fetchUsersContainingCallsCount, 1)
    }

    func test_didTapSearch_shouldInvokeFetch() throws {
        sut.searchString = "test"

        XCTAssertEqual(userService.fetchUsersContainingCallsCount, 2)
    }
}
