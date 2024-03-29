extension SearchViewModel {
    static var mock: SearchViewModel {
        SearchViewModel(
            navigator: .init(sceneFactory: ContentSceneFactory(), root: .main),
            userDataService: UserDataServiceMock()
        )
    }
}
