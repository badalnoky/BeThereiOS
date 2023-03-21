import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        registerCoordinatorLayer()
        registerServiceLayer()
    }
}

extension Resolver {
    public static func registerCoordinatorLayer() {
        register {
            AuthenticationCoordinator(root: .login)
        }

        register {
            ContentCoordinator(root: .main)
        }

        register {
            AppCoordinator(
                authenticationCoordinator: Resolver.resolve(),
                contentCoordinator: Resolver.resolve()
            )
        }
    }
}

extension Resolver {
    public static func registerServiceLayer() {
        register {
            AuthenticatonService(dataService: Resolver.resolve())
        }
        .implements(AuthenticationServiceInput.self)
        .scope(.application)

        register {
            DataService()
        }
        .implements(DataServiceInput.self)
        .scope(.application)

        register {
            EventDataService()
        }
        .implements(EventDataServiceInput.self)
        .scope(.application)
    }
}
