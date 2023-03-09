extension SettingsViewModel {
    static var mock: SettingsViewModel {
        SettingsViewModel(navigator: .init(sceneFactory: ContentSceneFactory(), root: .main))
    }
}
