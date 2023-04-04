@testable import BeThere
import XCTest

// swiftlint:disable: implicitly_unwrapped_optional
final class MessageTests: XCTestCase {
    private typealias Keys = Txt.Message
    private var sut: Message!

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
        let sentBy = result[Keys.sentBy] as? String
        let text = result[Keys.text] as? String

        XCTAssertEqual(count, 3)
        XCTAssertEqual(id, Keys.Mock.id)
        XCTAssertEqual(sentBy, Keys.Mock.sentBy)
        XCTAssertEqual(text, Keys.Mock.text)
    }

    func test_initFromDocument_shouldReturnMessage() throws {
        let dictionary: [String: Any] = [
            Keys.id: Keys.Mock.id,
            Keys.sentBy: Keys.Mock.sentBy,
            Keys.text: Keys.Mock.text
        ]

        let result = Message(fromDocument: dictionary)

        XCTAssertEqual(result, .mock)
    }

    func test_fromDocument_shouldReturnMessageArray() throws {
        let dictionary: [[String: Any]] = [
            [
                Keys.id: Keys.Mock.id,
                Keys.sentBy: Keys.Mock.sentBy,
                Keys.text: Keys.Mock.text
            ],
            [
                Keys.id: "id2",
                Keys.sentBy: "sentBy2",
                Keys.text: "text2"
            ],
            [
                Keys.id: "id3",
                Keys.sentBy: "sentBy3",
                Keys.text: "text3"
            ]
        ]

        let result = Message.fromDocument(dictionary)
        let expected2 = Message(id: "id2", sentBy: "sentBy2", text: "text2")
        let expected3 = Message(id: "id3", sentBy: "sentBy3", text: "text3")

        XCTAssertEqual(result.count, 3)
        XCTAssertEqual(result[0], .mock)
        XCTAssertEqual(result[1], expected2)
        XCTAssertEqual(result[2], expected3)
    }
}
