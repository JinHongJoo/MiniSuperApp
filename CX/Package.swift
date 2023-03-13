// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CX",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "AppHome",
            targets: ["AppHome"]),
    ],
    dependencies: [
        .package(url: "https://github.com/DevYeom/ModernRIBs.git", from: "1.0.2"),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.6.0")),
        .package(path: "../Finance"),
        .package(path: "../Transport"),
        .package(path: "../Platform")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "AppHome",
            dependencies: [
                "ModernRIBs",
                "SnapKit",
                .product(name: "FinanceRepository", package: "Finance"),
                .product(name: "TransportHome", package: "Transport"),
                .product(name: "SuperUI", package: "Platform"),
            ]),
    ]
)
