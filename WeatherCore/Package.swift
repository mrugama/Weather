// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WeatherCore",
    platforms: [.iOS(.v17)],
    products: [
        // MARK: - Feature components
        .library(
            name: "LandingPage",
            targets: ["LandingPage"]
        ),
    ],
    targets: [
        // MARK: - Modules
        .target(
            name: "WTLogging",
            path: "Sources/Foundation/WTLogging"),
        .target(
            name: "Networking",
            dependencies: ["WTLogging"],
            path: "Sources/Foundation/Networking"),
        .target(
            name: "EndpointManager",
            dependencies: ["WTLogging"],
            path: "Sources/Foundation/EndpointManager"),
        .target(
            name: "RestAPI",
            dependencies: ["Networking", "EndpointManager", "WTLogging"],
            path: "Sources/WeatherFeature/RestAPI"
        ),
        .target(
            name: "LandingPage",
            dependencies: ["RestAPI", "DecoratorUI", "RestAPITestUtilities", "Networking", "NetworkingTestUtilities", "WTLogging"],
            path: "Sources/WeatherFeature/LandingPage"
        ),
        .target(
            name: "DecoratorUI",
            path: "Sources/WeatherFeature/DecoratorUI",
            resources: [.process("Media.xcassets")]
        ),
        
        // MARK: - Shared Test Utility Targets
        .target(
            name: "NetworkingTestUtilities",
            dependencies: ["Networking"],
            path: "Sources/Foundation/NetworkingTestUtilities"
        ),
        .target(
            name: "EndpointManagerTestUtilities",
            dependencies: ["EndpointManager"],
            path: "Sources/Foundation/EndpointManagerTestUtilities"
        ),
        .target(
            name: "RestAPITestUtilities",
            dependencies: ["RestAPI"],
            path: "Sources/WeatherFeature/RestAPITestUtilities",
            resources: [.copy("data/weather.json")]
        ),
        
        // MARK: Testing Target definition
        .testTarget(
            name: "NetworkingTests",
            dependencies: [
                "Networking"
            ],
            path: "Sources/Foundation/NetworkingTests"
        ),
        .testTarget(
            name: "EndpointManagerTests",
            dependencies: [
                "EndpointManager",
                "EndpointManagerTestUtilities",
            ],
            path: "Sources/Foundation/EndpointManagerTests"
        ),
        .testTarget(
            name: "RestAPITests",
            dependencies: [
                "NetworkingTestUtilities",
                "RestAPI",
                "RestAPITestUtilities"
            ],
            path: "Sources/WeatherFeature/RestAPITests"
        ),
        .testTarget(
            name: "LandingPageTests",
            dependencies: [
                "NetworkingTestUtilities",
                "RestAPITestUtilities",
                "LandingPage",
                "RestAPI",
            ],
            path: "Sources/WeatherFeature/LandingPageTests"
        ),
    ]
)
