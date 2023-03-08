extension SuccessfulRegistrationViewModel {
    static var mock: SuccessfulRegistrationViewModel {
        SuccessfulRegistrationViewModel(navigator: .init(sceneFactory: AuthenticationSceneFactory(), root: .login))
    }
}
