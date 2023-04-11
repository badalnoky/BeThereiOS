@testable import BeThere
import Combine
import XCTest

// swiftlint:disable: implicitly_unwrapped_optional
final class SettingsViewModelTests: XCTestCase {
    private var sut: SettingsViewModel!
    private var userService: UserDataServiceInputMock!

    override func setUpWithError() throws {
        try super.setUpWithError()

        userService = .init()

        userService.user = CurrentValueSubject<User?, Never>(User.mock)

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
        XCTAssertEqual(sut.name, User.mock.name)
        XCTAssertEqual(sut.urlString, User.mock.photo)
    }

    func test_didTapSave_shouldUpdates() throws {
        sut.name = "newName"
        sut.hasImageChanged = true
        sut.image = UIImage()
        userService.uploadImageReturnValue = CurrentValueSubject(true)

        sut.didTapSave()

        XCTAssertEqual(userService.uploadImageCallsCount, 1)
        XCTAssertEqual(userService.updateUserNameToCallsCount, 1)
        XCTAssertFalse(sut.hasImageChanged)
    }
}
