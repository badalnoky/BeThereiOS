import Combine

public extension PassthroughSubject where Output == Bool, Failure == Never {
    func mapTo<T>(screen: T) -> AnyPublisher<T, Never> {
        self
            .filter { $0 }
            .map { _ in screen }
            .eraseToAnyPublisher()
    }
}

public extension Double {
    static let one: Double = 1
}

public extension String {
    static var empty: String = ""
}
