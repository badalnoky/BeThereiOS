extension AddMemberViewModel {
    static var mock: AddMemberViewModel {
        AddMemberViewModel(navigator: .init(sceneFactory: ContentSceneFactory(), root: .main))
    }
}
