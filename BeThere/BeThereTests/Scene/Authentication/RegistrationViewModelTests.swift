@testable import BeThere
import Combine
import XCTest

// swiftlint:disable: implicitly_unwrapped_optional
final class RegistrationViewModelTests: XCTestCase {
    private var sut: RegistrationViewModel!
    private var service: AuthenticationServiceInputMock!

    override func setUpWithError() throws {
        try super.setUpWithError()

        service = .init()

        sut = .init(
            navigator: .init(sceneFactory: AuthenticationSceneFactory(), root: .login),
            authenticationService: service
        )
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()

        sut = nil

        service = nil
    }

    func test_didTapRegistrate_shouldInvokeRegistrate() throws {
        service.registrateEmailPasswordNameReturnValue = CurrentValueSubject(true)

        sut.didTapRegistrate()

        XCTAssertTrue(service.registrateEmailPasswordNameCalled)
        XCTAssertEqual(service.registrateEmailPasswordNameCallsCount, 1)
    }
}
