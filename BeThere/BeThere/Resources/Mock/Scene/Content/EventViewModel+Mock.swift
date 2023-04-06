extension EventViewModel {
    static var mock: EventViewModel {
        EventViewModel(
            navigator: .init(sceneFactory: ContentSceneFactory(), root: .main),
            eventService: EventDataServiceMock(),
            userDataService: UserDataServiceMock()
        )
    }
}
