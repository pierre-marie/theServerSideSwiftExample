import Kitura
import CloudEnvironment

public func initializeCRUDResources(cloudEnv: CloudEnv, router: Router) throws {
    let factory = AdapterFactory(cloudEnv: cloudEnv)
    try CreatureResource(factory: factory).setupRoutes(router: router)
}
