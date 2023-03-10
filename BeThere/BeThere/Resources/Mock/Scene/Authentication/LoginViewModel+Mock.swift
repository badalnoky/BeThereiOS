extension LoginViewModel {
    static var mock: LoginViewModel {
        LoginViewModel(navigator: .init(sceneFactory: AuthenticationSceneFactory(), root: .login))
    }
}
