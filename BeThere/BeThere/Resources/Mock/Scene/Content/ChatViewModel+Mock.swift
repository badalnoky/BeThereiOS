extension ChatViewModel {
    static var mock: ChatViewModel {
        ChatViewModel(
            navigator: .init(sceneFactory: ContentSceneFactory(), root: .main),
            eventService: EventDataServiceMock(),
            userDataService: UserDataServiceMock(),
            eventId: .empty
        )
    }
}
