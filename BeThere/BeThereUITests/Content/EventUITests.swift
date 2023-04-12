import XCTest

// swiftlint: disable: line_length
final class EventUITests: XCTestCase {
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
        app.scrollViews.otherElements.buttons["UI Test"].tap()
        app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"]/*@START_MENU_TOKEN@*/.buttons["Edit"]/*[[".otherElements[\"Edit\"].buttons[\"Edit\"]",".buttons[\"Edit\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func test_Event_back_shouldNavigateBack() {
        app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"]/*@START_MENU_TOKEN@*/.buttons["Back"]/*[[".otherElements[\"Back\"].buttons[\"Back\"]",".buttons[\"Back\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

        let textField = app.textFields["Send a message"]
        _ = textField.waitForExistence(timeout: 5)
        XCTAssertTrue(textField.exists)
    }

    func test_Event_addMembers_shouldNavigateToAddMember() {
        app.buttons["person.fill.badge.plus"].tap()

        let searchForUsersTextField = app.textFields["Search for users"]
        _ = searchForUsersTextField.waitForExistence(timeout: 5)
        XCTAssertTrue(searchForUsersTextField.exists)
    }
}
