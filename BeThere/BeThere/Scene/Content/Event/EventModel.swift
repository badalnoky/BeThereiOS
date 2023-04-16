public enum EventState {
    case creation, modification
}

public enum SaveEventError {
    case name
    case location

    private typealias Error = Txt.Error

    public var description: String {
        switch self {
        case .name: return Error.nameLength
        case .location: return Error.locationLength
        }
    }
}
