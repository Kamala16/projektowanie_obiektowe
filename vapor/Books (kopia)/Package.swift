// swift-tools-version:5.2
import PackageDescription

let vapor = "https://github.com/vapor/vapor.git"
let fluent = "https://github.com/vapor/fluent.git"
let sqlite = "https://github.com/vapor/fluent-sqlite-driver.git"
let leaf = "https://github.com/vapor/leaf.git"

let package = Package(
    name: "Books",
    platforms: [
       .macOS(.v10_15)
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: vapor, from: "4.0.0"),
        .package(url: fluent, from: "4.0.0"),
        .package(url: sqlite, from: "4.0.0"),
        .package(url: leaf, from: "4.0.0"),

    ],
    targets: [
        .target(
            name: "App",
            dependencies: [
                .product(name: "Fluent", package: "fluent"),
                .product(name: "FluentSQLiteDriver", package: "fluent-sqlite-driver"),
                .product(name: "Leaf", package: "leaf"),
                .product(name: "Vapor", package: "vapor")
            ],
            swiftSettings: [
                // Enable better optimizations when building in Release configuration. Despite the use of
                // the `.unsafeFlags` construct required by SwiftPM, this flag is recommended for Release
                // builds. See <https://github.com/swift-server/guides#building-for-production> for details.
                .unsafeFlags(["-cross-module-optimization"], .when(configuration: .release))
            ]
        ),
        .target(name: "Run", dependencies: [.target(name: "App")]),
        .testTarget(name: "AppTests", dependencies: [
            .target(name: "App"),
            .product(name: "XCTVapor", package: "vapor"),
        ])
    ]
)
