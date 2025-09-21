// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TrainingButton",
    platforms: [
        .iOS(.v26),
    ],
    products: [
        .library(
            name: "TrainingButton",
            targets: ["TrainingButton"]
        ),
    ],
    dependencies: [
        .package(path: "../Util"),
    ],
    targets: [
        .target(
            name: "TrainingButton",
            dependencies: [
                .product(name: "Util", package: "Util")
            ]
        ),
    ]
)
