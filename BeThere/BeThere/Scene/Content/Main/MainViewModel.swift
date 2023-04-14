import BaseKit
import Combine

final class MainViewModel: ObservableObject {
    private var navigator: Navigator<ContentSceneFactory>
    private var authenticationService: AuthenticationServiceInput
    private var userDataService: UserDataServiceInput
    private var eventService: EventDataServiceInput
    private var cancellables = Set<AnyCancellable>()

    @Published var filteredEvents: [Event] = []
    @Published var searchString: String = .empty {
        didSet { setFilteredEvents() }
    }

    var allEvents: [Event] = [] {
        didSet { setFilteredEvents() }
    }

    init(
        navigator: Navigator<ContentSceneFactory>,
        authenticationService: AuthenticationServiceInput,
        userDataService: UserDataServiceInput,
        eventService: EventDataServiceInput
    ) {
        self.navigator = navigator
        self.authenticationService = authenticationService
        self.userDataService = userDataService
        self.eventService = eventService

        registerBindings()
    }
}

extension MainViewModel {
    func didTapSignOut() {
        authenticationService.signOut()
            .sink(
                receiveValue: { [weak self] in if $0 { self?.navigator.finishFlow() } },
                receiveError: { _ in
                    // TODO: handle error
                }
            )
            .store(in: &cancellables)
    }

    func didTapAddFriends() {
        navigator.showSearch()
    }

    func didTapSettings() {
        navigator.showSettings()
    }

    func didTapEvent(id: String) {
        navigator.showChat(for: id)
    }

    func didTapCreate() {
        navigator.showEvent()
    }
}

private extension MainViewModel {
    func registerBindings() {
        registerUserBinding()
        registerEventsBinding()
    }

    func registerUserBinding() {
        userDataService.user
            .sink { [weak self] in
                if let user = $0 {
                    self?.eventService.getEvents(for: user)
                }
            }
            .store(in: &cancellables)
    }

    func registerEventsBinding() {
        eventService.userEvents
            .sink { [weak self] in
                self?.allEvents = $0
            }
            .store(in: &cancellables)
    }

    func setFilteredEvents() {
        if !searchString.isEmpty {
            filteredEvents = allEvents.filter { $0.name.caseInsensitiveContains(searchString) }
        } else {
            filteredEvents = allEvents
        }
    }
}
