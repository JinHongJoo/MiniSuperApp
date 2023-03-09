// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Transport",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "TransportHome",
            targets: ["TransportHome"]),
    ],
    dependencies: [
        .package(url: "https://github.com/DevYeom/ModernRIBs.git", from: "1.0.2"),
        .package(path: "../Finance"),
        .package(path: "../Platform")
    ],
    targets: [
        .target(
            name: "TransportHome",
            dependencies: [
                "ModernRIBs",
                .product(name: "FinanceRepository", package: "Finance"),
                .product(name: "Topup", package: "Finance"),
            ],
            resources: [
                .process("Resources")
            ]),
    ]
)
