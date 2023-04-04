@testable import BeThere
import XCTest

// swiftlint:disable: implicitly_unwrapped_optional
final class UserTests: XCTestCase {
    private typealias Keys = Txt.User
    private var sut: User!

    override func setUpWithError() throws {
        try super.setUpWithError()

        sut = .mock
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()

        sut = nil
    }

    func test_defaultDocumentValue_shouldReturnDictionary() throws {
        let result = sut.defaultDocumentValue

        let count = result.count
        let id = result[Keys.id] as? String
        let name = result[Keys.name] as? String
        let photo = result[Keys.photo] as? String
        let friends = result[Keys.friends] as? [String]
        let events = result[Keys.events] as? [String]

        XCTAssertEqual(count, 5)
        XCTAssertEqual(id, Keys.Mock.id)
        XCTAssertEqual(name, Keys.Mock.name)
        XCTAssertEqual(photo, Keys.Mock.photo)
    }

    func test_initFromDocument_shouldReturnMessage() throws {
        let dictionary: [String: Any] = [
            Keys.id: Keys.Mock.id,
            Keys.name: Keys.Mock.name,
            Keys.photo: Keys.Mock.photo,
            Keys.friends: [],
            Keys.events: []
        ]

        let result = User(fromDocument: dictionary)

        XCTAssertEqual(result, .mock)
    }
}
