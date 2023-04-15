public extension String {
    static var empty: String = ""
    static var person: String = "person.circle.fill"

    var isStrong: Bool {
        let isLong = self.count > 7
        let hasUpperCase = NSPredicate(format: "SELF MATCHES %@", ".*[A-Z]+.*").evaluate(with: self)
        let hasLowerCase = NSPredicate(format: "SELF MATCHES %@", ".*[a-z]+.*").evaluate(with: self)
        let hasNumeric = NSPredicate(format: "SELF MATCHES %@", ".*[0-9]+.*").evaluate(with: self)

        return isLong && hasUpperCase && hasLowerCase && hasNumeric
    }

    func caseInsensitiveContains(_ substring: String) -> Bool {
        self.range(of: substring, options: .caseInsensitive) != nil
    }
}
