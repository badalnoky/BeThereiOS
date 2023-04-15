import Foundation

class AuthenticationErrorHandler {
    @Published var alertText: String = .empty
    @Published var displayAlert = false

    func handleError(_ error: Error) {
        alertText = error.localErrorDescription
        displayAlert = true
    }
}
