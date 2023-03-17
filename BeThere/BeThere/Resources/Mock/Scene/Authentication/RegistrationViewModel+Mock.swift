extension RegistrationViewModel {
    static var mock: RegistrationViewModel {
        RegistrationViewModel(
            navigator: .init(sceneFactory: AuthenticationSceneFactory(), root: .login),
            authenticationService: AuthenticatonServiceMock()
        )
    }
}
