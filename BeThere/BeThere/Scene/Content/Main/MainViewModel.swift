import BaseKit
import Combine

final class MainViewModel: ObservableObject {
    private var navigator: Navigator<ContentSceneFactory>
    private var authenticationService: AuthenticationServiceInput
    private var dataService: DataServiceInput
    private var eventService: EventDataServiceInput
    private var cancellables = Set<AnyCancellable>()

    @Published var searchString: String = .empty
    @Published var filteredEvents: [Event] = []

    var allEvents: [Event] = [] {
        didSet {
            if searchString.count > 2 {
                filteredEvents = allEvents.filter { $0.name.contains(searchString) }
            } else {
                filteredEvents = allEvents
            }
        }
    }

    init(
        navigator: Navigator<ContentSceneFactory>,
        authenticationService: AuthenticationServiceInput,
        dataService: DataServiceInput,
        eventService: EventDataServiceInput
    ) {
        self.navigator = navigator
        self.authenticationService = authenticationService
        self.dataService = dataService
        self.eventService = eventService

        registerBindings()
    }
}

extension MainViewModel {
    func didTapSignOut() {
        authenticationService.signOut()
            .sink(
                receiveValue: { [weak self] in if $0 { self?.navigator.finishFlow() } },
                receiveError: { print($0) }
            )
            .store(in: &cancellables)
    }

    func didTapAddFriends() {
        navigator.showSearch()
    }

    func didTapSettings() {
        navigator.showSettings()
    }

    func didTapEvent() {
        navigator.showChat()
    }

    func didTapCreate() {
        navigator.showEvent()
    }

    func didTapSearch() {
        if searchString.count > 2 {
            filteredEvents = allEvents.filter { $0.name.contains(searchString) }
        } else {
            filteredEvents = allEvents
            // TODO: show error message
        }
    }
}

private extension MainViewModel {
    func registerBindings() {
        registerUserBinding()
        registerEventsBinding()
    }

    func registerUserBinding() {
        dataService.user
            .sink { [weak self] in
                if let user = $0 {
                    self?.eventService.getEvents(user.events)
                }
            }
            .store(in: &cancellables)
    }

    func registerEventsBinding() {
        eventService.events
            .sink { [weak self] in
                self?.allEvents = $0
            }
            .store(in: &cancellables)
    }
}
