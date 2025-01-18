// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WeatherCore",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "RestAPI",
            targets: ["RestAPI"]
        ),
        .library(
            name: "WeatherUI",
            targets: ["WeatherUI"]
        ),
    ],
    targets: [
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
            name: "WeatherUI",
            dependencies: ["RestAPI", "DecoratorUI"],
            path: "Sources/WeatherFeature/WeatherUI"
        ),
        .target(
            name: "DecoratorUI",
            path: "Sources/WeatherFeature/DecoratorUI"
        ),
        
        // MARK: - Shared Test Utilities Target
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
            path: "Sources/WeatherFeature/RestAPITestUtilities"
        ),
        .target(
            name: "CommonTestUtilities",
            path: "Sources/CommonTestUtilities"
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
                "RestAPI",
                "RestAPITestUtilities",
                "EndpointManagerTestUtilities",
                "NetworkingTestUtilities",
                "CommonTestUtilities",
            ],
            path: "Sources/WeatherFeature/RestAPITests"
        ),
    ]
)
