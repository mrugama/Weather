// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WeatherCore",
    platforms: [.iOS(.v17)],
    products: [
        // MARK: - Feature components
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
            name: "WeatherUI",
            dependencies: ["RestAPI", "DecoratorUI", "Model", "RestAPITestUtilities", "NetworkingTestUtilities"],
            path: "Sources/WeatherFeature/WeatherUI"
        ),
        .target(
            name: "DecoratorUI",
            path: "Sources/WeatherFeature/DecoratorUI"
        ),
        .target(
            name: "Model",
            path: "Sources/WeatherFeature/Model"
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
        .target(
            name: "WeatherUITestUtilities",
            path: "Sources/WeatherFeature/WeatherUITestUtilities"
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
                "Model",
                "NetworkingTestUtilities",
                "RestAPI",
                "RestAPITestUtilities",
            ],
            path: "Sources/WeatherFeature/RestAPITests"
        ),
        .testTarget(
            name: "WeatherUITests",
            dependencies: [
                "Model",
                "NetworkingTestUtilities",
                "RestAPITestUtilities",
                "WeatherUI",
                "WeatherUITestUtilities",
            ],
            path: "Sources/WeatherFeature/WeatherUITests"
        ),
    ]
)
