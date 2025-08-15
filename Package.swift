// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "DanieleRolliCapacitorSpotsearch",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "DanieleRolliCapacitorSpotsearch",
            targets: ["DanieleRolliCapacitorSpotsearch"])
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", from: "7.0.0")
    ],
    targets: [
        .target(
            name: "DanieleRolliCapacitorSpotsearch",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm")
            ],
            path: "ios/Plugin",
            publicHeadersPath: "."
        )
    ]
)
