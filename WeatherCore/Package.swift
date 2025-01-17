// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WeatherCore",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Networking",
            targets: ["Networking"]
        ),
        .library(
            name: "EndpointManager",
            targets: ["EndpointManager"]
        ),
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
        .testTarget(
            name: "WeatherCoreTests",
            dependencies: ["RestAPI"]
        ),
    ]
)
