public extension String {
    static var empty: String = ""
    static var person: String = "person.circle.fill"

    func caseInsensitiveContains(_ substring: String) -> Bool {
        self.range(of: substring, options: .caseInsensitive) != nil
    }
}
