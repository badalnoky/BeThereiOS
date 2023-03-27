extension ChatViewModel {
    static var mock: ChatViewModel {
        ChatViewModel(
            navigator: .init(sceneFactory: ContentSceneFactory(), root: .main),
            evetService: EventDataServiceMock(),
            userDataService: UserDataServiceMock(),
            eventId: .empty
        )
    }
}
