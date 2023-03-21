import BaseKit
import Combine

public final class SearchViewModel: ObservableObject {
    private var navigator: Navigator<ContentSceneFactory>
    private var dataService: DataServiceInput
    private var cancellables = Set<AnyCancellable>()

    @Published var searchString: String = .empty
    @Published var otherUsers: [User] = []

    init(
        navigator: Navigator<ContentSceneFactory>,
        dataService: DataServiceInput
    ) {
        self.navigator = navigator
        self.dataService = dataService

        registerBindings()
    }
}

extension SearchViewModel {
    func didTapSearch() {
        if searchString.count > 2 {
            dataService.fetchUsers(containing: searchString)
        } else {
            // TODO: show error message
        }
    }
}

private extension SearchViewModel {
    func registerBindings() {
        dataService.foundUsers
            .sink { [weak self] users in
                self?.otherUsers = users
            }
            .store(in: &cancellables)
    }
}
