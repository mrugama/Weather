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
        // MARK: - Components
        .target(
            name: "Networking",
            path: "Sources/Foundation/Networking"),
        .target(
            name: "EndpointManager",
            path: "Sources/Foundation/EndpointManager"),
        .target(
            name: "RestAPI",
            dependencies: ["Networking", "EndpointManager"],
            path: "Sources/WeatherFeature/RestAPI"
        ),
        .target(
            name: "LandingPage",
            dependencies: ["RestAPI", "DecoratorUI", "RestAPITestUtilities", "Networking", "NetworkingTestUtilities"],
            path: "Sources/WeatherFeature/LandingPage"
        ),
        .target(
            name: "DecoratorUI",
            path: "Sources/WeatherFeature/DecoratorUI"
        ),
        
        // MARK: - Shared Test Utilities Targets
        .target(
            name: "NetworkingTestUtilities",
            path: "Sources/Foundation/NetworkingTestUtilities"
        ),
        .target(
            name: "EndpointManagerTestUtilities",
            path: "Sources/Foundation/EndpointManagerTestUtilities"
        ),
        .target(
            name: "RestAPITestUtilities",
            path: "Sources/WeatherFeature/RestAPITestUtilities",
            resources: [.copy("data/weather.json")]
        ),
        
        // MARK: Testing Target definition
        .testTarget(
            name: "NetworkingTests",
            dependencies: [
                "Networking",
                "NetworkingTestUtilities",
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
                "RestAPITestUtilities",
                "LandingPage"
            ],
            path: "Sources/WeatherFeature/RestAPITests"
        ),
        .testTarget(
            name: "LandingPageTests",
            dependencies: [
                "NetworkingTestUtilities",
                "RestAPITestUtilities",
                "LandingPage",
            ],
            path: "Sources/WeatherFeature/LandingPageTests"
        ),
    ]
)
