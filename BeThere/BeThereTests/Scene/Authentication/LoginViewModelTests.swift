@testable import BeThere
import Combine
import XCTest

// swiftlint:disable: implicitly_unwrapped_optional
final class LoginViewModelTests: XCTestCase {
    private var sut: LoginViewModel!
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

    func test_didTapLogin_shouldInvokeSignIn() throws {
        service.signInEmailPasswordReturnValue = CurrentValueSubject(true)

        sut.didTapLogin()

        XCTAssertTrue(service.signInEmailPasswordCalled)
        XCTAssertEqual(service.signInEmailPasswordCallsCount, 1)
    }
}
