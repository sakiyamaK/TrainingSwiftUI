// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TrainingBasic",
    platforms: [
        .iOS(.v26),
    ],
    products: [
        .library(
            name: "TrainingBasic",
            targets: ["TrainingBasic"]
        ),
    ],
    dependencies: [
        .package(path: "../Util"),
    ],
    targets: [
        .target(
            name: "TrainingBasic",
            dependencies: [
                .product(name: "Util", package: "Util")
            ]
        ),
    ]
)
