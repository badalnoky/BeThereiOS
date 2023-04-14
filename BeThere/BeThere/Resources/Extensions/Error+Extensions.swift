import FirebaseAuth

extension Error {
    private typealias Errors = Txt.Error
    var authErrorDescription: String {
        let error = self as NSError
        switch error.code {
        case AuthErrorCode.wrongPassword.rawValue: return Errors.wrongPassword
        case AuthErrorCode.invalidEmail.rawValue: return Errors.emailFormat
        case AuthErrorCode.emailAlreadyInUse.rawValue: return Errors.takenEmail
        case AuthErrorCode.userNotFound.rawValue: return Errors.nonUser
        case AuthErrorCode.networkError.rawValue: return Errors.network
        default: return Errors.unknown
        }
    }
}
