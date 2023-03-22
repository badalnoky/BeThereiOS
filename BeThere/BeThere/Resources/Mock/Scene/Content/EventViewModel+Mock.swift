extension EventViewModel {
    static var mock: EventViewModel {
        EventViewModel(
            navigator: .init(sceneFactory: ContentSceneFactory(), root: .main),
            evetService: EventDataServiceMock(),
            dataService: DataServiceMock()
        )
    }
}
