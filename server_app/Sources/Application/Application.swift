import Foundation
import Kitura
import LoggerAPI
import Configuration
import CloudEnvironment
import Generated
import Health

public let router = Router()
public let cloudEnv = CloudEnv()
public let projectPath = ConfigurationManager.BasePath.project.path
public var port: Int = 4242
public let health = Health()

public func initialize() throws {
    // Configuration
    port = cloudEnv.port

    // Capabilities
    initializeMetrics()

    // Services

    // Middleware
    router.all(middleware: BodyParser())
    router.all(middleware: StaticFileServer())

    // Endpoints
    try initializeCRUDResources(cloudEnv: cloudEnv, router: router)
    initializeHealthRoutes()
    initializeSwaggerRoutes(path: projectPath + "/definitions/server_app.yaml")
}

public func run() throws {
    Kitura.addHTTPServer(onPort: port, with: router)
    Kitura.run()
}
