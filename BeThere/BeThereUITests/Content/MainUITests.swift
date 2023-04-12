import XCTest

// swiftlint: disable: line_length
final class MainUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app.launch()

        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.typeText("ios@test.com")

        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("Asdasd")

        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Sign in"].tap()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func test_Main_addFriend_shouldNavigateToAddFriend() {
        let navigationBar = app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"]
        navigationBar/*@START_MENU_TOKEN@*/.buttons["person.fill.badge.plus"]/*[[".otherElements[\"person.fill.badge.plus\"].buttons[\"person.fill.badge.plus\"]",".buttons[\"person.fill.badge.plus\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

        let searchForUsersTextField = app.textFields["Search for users"]
        _ = searchForUsersTextField.waitForExistence(timeout: 5)
        XCTAssertTrue(searchForUsersTextField.exists)
    }

    func test_Main_settings_shouldNavigateToSettings() {
        let navigationBar = app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"]
        navigationBar/*@START_MENU_TOKEN@*/.buttons["Settings"]/*[[".otherElements[\"Settings\"].buttons[\"Settings\"]",".buttons[\"Settings\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

        let saveButton = app.buttons["Save"]
        _ = saveButton.waitForExistence(timeout: 5)
        XCTAssertTrue(saveButton.exists)
    }

    func test_Main_searchAndTap_shouldShowResultAndNavigateToEvent() {
        let searchField = app.textFields["Search"]
        searchField.tap()
        searchField.typeText("UI Test")

        app.scrollViews.otherElements.buttons["UI Test"].tap()

        let messageField = app.textFields["Send a message"]
        _ = messageField.waitForExistence(timeout: 5)
        XCTAssertTrue(messageField.exists)
    }

    func test_Main_registrate_shouldNavigate() {
        let navigationBar = app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"]
        navigationBar/*@START_MENU_TOKEN@*/.buttons["rectangle.portrait.and.arrow.right"]/*[[".otherElements[\"rectangle.portrait.and.arrow.right\"].buttons[\"rectangle.portrait.and.arrow.right\"]",".buttons[\"rectangle.portrait.and.arrow.right\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

        let emailTextField = app.textFields["Email"]
        _ = emailTextField.waitForExistence(timeout: 5)
        XCTAssertTrue(emailTextField.exists)
    }
}
