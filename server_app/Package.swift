import PackageDescription

let package = Package(
    name: "server_app",
    targets: [
      Target(name: "server_app", dependencies: [ .Target(name: "Application") ]),
      Target(name: "Application", dependencies: [
            .Target(name: "Generated"),
      ]),
    ],
    dependencies: [
        .Package(url: "https://github.com/IBM-Swift/Kitura.git",             majorVersion: 1, minor: 7),
        .Package(url: "https://github.com/IBM-Swift/HeliumLogger.git",       majorVersion: 1, minor: 7),
        .Package(url: "https://github.com/IBM-Swift/CloudEnvironment.git", majorVersion: 4),
        .Package(url: "https://github.com/RuntimeTools/SwiftMetrics.git", majorVersion: 1),
        .Package(url: "https://github.com/IBM-Swift/Health.git", majorVersion: 0),
    ],
    exclude: ["src"]
)
