// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Finance",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "AddPaymentMethod",
            targets: ["AddPaymentMethod"]),
        .library(
            name: "FinanceEntity",
            targets: ["FinanceEntity"]),
        .library(
            name: "FinanceRepository",
            targets: ["FinanceRepository"]),
    ],
    dependencies: [
        .package(url: "https://github.com/DevYeom/ModernRIBs.git", from: "1.0.2"),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.6.0")),
        .package(path: "../Platform")
    ],
    targets: [
        .target(
            name: "AddPaymentMethod",
            dependencies: [
                "ModernRIBs",
                "SnapKit",
                .product(name: "SuperUI", package: "Platform"),
                "FinanceEntity",
                "FinanceRepository"
            ]),
        .target(
            name: "FinanceEntity",
            dependencies: [
            ]),
        .target(
            name: "FinanceRepository",
            dependencies: [
                .product(name: "CombineUtils", package: "Platform"),
                "FinanceEntity",
            ]),
    ]
)
