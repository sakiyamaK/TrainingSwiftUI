// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "WWDC",
    platforms: [.iOS(.v26)],
    products: [
        .library(
            name: "WWDC",
            targets: ["WWDC"]
        ),
    ],
    targets: [
        .target(
            name: "WWDC",
            swiftSettings: [
                .defaultIsolation(MainActor.self),
            ]
        ),
    ]
)
