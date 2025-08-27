// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "MySGBGame",
    platforms: [.macOS(.v14)],
    products: [
        .library(
            name: "MySGBGame",
            type: .dynamic,
            targets: ["MySGBGame"]
        ),
        .executable(
            name: "exec",
            targets: ["exec"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/johnsusek/SwiftGodotBuilder", revision: "a7137473c42dc98c82c283ef2eda182ed5b1835a"),
        .package(url: "https://github.com/migueldeicaza/SwiftGodot", revision: "a1af0de831a22a2f1d5d8b4221d9df2fdd12978f"),
        .package(url: "https://github.com/migueldeicaza/SwiftGodotKit", revision: "7f59a1ad97d243a071b548bed7ff573449c82af5"),
    ],
    targets: [
        .target(
            name: "MySGBGame",
            dependencies: [
                .product(name: "SwiftGodot", package: "SwiftGodot"),
                .product(name: "SwiftGodotBuilder", package: "SwiftGodotBuilder"),
            ]
        ),
        .executableTarget(
            name: "exec",
            dependencies: [
                "MySGBGame",
                .product(name: "SwiftGodotKit", package: "SwiftGodotKit"),
            ],
            resources: [
                .copy("Resources"),
            ]
        ),
    ]
)
