import XCTest

// swiftlint: disable: line_length
final class AddMemberUITests: XCTestCase {
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
        app.buttons["person.fill.badge.plus"].tap()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func test_AddMember_back_shouldNavigateBack() {
        app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"]/*@START_MENU_TOKEN@*/.buttons["Back"]/*[[".otherElements[\"Back\"].buttons[\"Back\"]",".buttons[\"Back\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

        let text = app.staticTexts["Time and Date:"]
        _ = text.waitForExistence(timeout: 5)
        XCTAssertTrue(text.exists)
    }
}
