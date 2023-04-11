import XCTest

// swiftlint: disable: line_length
final class LoginUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func test_Login_registrate_shouldNavigate() {
        app.buttons["registrate"].tap()
        let emailTextField = app.textFields["Email"]

        _ = emailTextField.waitForExistence(timeout: 5)
        XCTAssertTrue(emailTextField.exists)
    }

    func test_Login_signIn_shouldSignIn() {
        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.typeText("ios@test.com")

        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("Asdasd")

        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Sign in"].tap()

        let searchField = app.textFields["Search"]
        _ = searchField.waitForExistence(timeout: 5)
        XCTAssertTrue(searchField.exists)
    }
}
