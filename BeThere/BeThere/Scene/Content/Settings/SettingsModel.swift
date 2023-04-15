public enum SettingsMessage {
    case successfulUpload
    case uploadError

    private typealias Message = Txt.UploadMessage

    public var description: String {
        switch self {
        case .successfulUpload: return Message.success
        case .uploadError: return Message.error
        }
    }
}
