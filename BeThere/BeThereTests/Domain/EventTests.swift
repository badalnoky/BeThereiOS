@testable import BeThere
import XCTest

// swiftlint:disable: implicitly_unwrapped_optional
final class EventTests: XCTestCase {
    private typealias Keys = Txt.Event
    private var sut: Event!

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
        let location = result[Keys.location] as? String
        let date = result[Keys.date] as? Date
        let users = result[Keys.users] as? [String]

        XCTAssertEqual(count, 6)
        XCTAssertEqual(id, Keys.Mock.id)
        XCTAssertEqual(name, Keys.Mock.name)
        XCTAssertEqual(location, Keys.Mock.location)
        XCTAssertEqual(date, Date.defaultDateTime)
        XCTAssertEqual(users, [Keys.Mock.userId])
    }

    func test_getDifference_shouldReturnDictionary() throws {
        let newEvent = Event(
            id: Keys.Mock.id,
            name: "newName",
            location: "newLocation",
            date: .defaultDateTime,
            users: [Keys.Mock.userId, "newUserId"],
            messages: []
        )

        let result = sut.getDifference(from: newEvent)
        let count = result.count
        let name = result[Keys.name] as? String
        let location = result[Keys.location] as? String
        let users = result[Keys.newUsers] as? [String]

        XCTAssertEqual(count, 4)
        XCTAssertEqual(name, "newName")
        XCTAssertEqual(location, "newLocation")
        XCTAssertEqual(users, ["newUserId"])
    }
}
