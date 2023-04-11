import XCTest

// swiftlint: disable: line_length
final class RegistrationUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app.launch()
        app.buttons["registrate"].tap()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func test_Registration_back_shouldNavigateBack() {
        app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"]/*@START_MENU_TOKEN@*/.buttons["Back"]/*[[".otherElements[\"Back\"].buttons[\"Back\"]",".buttons[\"Back\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let emailTextField = app.textFields["Email"]

        _ = emailTextField.waitForExistence(timeout: 5)
        XCTAssertTrue(emailTextField.exists)
    }

    func test_Registration_fillForm_shouldEnableRegistration() {
        let elementsQuery = app.scrollViews.otherElements

        let emailTextField = elementsQuery.textFields["Email"]
        emailTextField.tap()
        emailTextField.typeText("UI@Test.com")

        let firstNameTextField = elementsQuery.textFields["First name"]
        firstNameTextField.tap()
        firstNameTextField.typeText("First")

        let lastNameTextField = elementsQuery.textFields["Last name"]
        lastNameTextField.tap()
        lastNameTextField.typeText("Last")

        let passwordSecureTextField = elementsQuery.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("Password00")

        let passwordAgainSecureTextField = elementsQuery.secureTextFields["Password again"]
        passwordAgainSecureTextField.tap()
        passwordAgainSecureTextField.typeText("Password00")

        let registrateButton = elementsQuery.buttons["Registrate"]

        XCTAssertTrue(registrateButton.isEnabled)
    }
}
