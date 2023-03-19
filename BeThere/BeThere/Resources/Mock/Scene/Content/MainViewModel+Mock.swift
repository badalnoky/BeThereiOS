extension MainViewModel {
    static var mock: MainViewModel {
        MainViewModel(
            navigator: .init(sceneFactory: ContentSceneFactory(), root: .main),
            authenticationService: AuthenticatonServiceMock(),
            dataService: DataServiceMock()
        )
    }
}
