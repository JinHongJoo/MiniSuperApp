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
            name: "FinanceHome",
            targets: ["FinanceHome"]),
        .library(
            name: "FinanceRepository",
            targets: ["FinanceRepository"]),
        .library(
            name: "Topup",
            targets: ["Topup"]),
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
                "FinanceEntity",
                "FinanceRepository",
                "ModernRIBs",
                "SnapKit",
                .product(name: "SuperUI", package: "Platform"),
            ]),
        .target(
            name: "FinanceEntity",
            dependencies: [
            ]),
        .target(
            name: "FinanceHome",
            dependencies: [
                "FinanceRepository",
                "ModernRIBs",
                "Topup",
            ]),
        .target(
            name: "FinanceRepository",
            dependencies: [
                "FinanceEntity",
                .product(name: "CombineUtils", package: "Platform"),
            ]),
        .target(
            name: "Topup",
            dependencies: [
                "AddPaymentMethod",
                "FinanceRepository",
                "ModernRIBs",
                .product(name: "CombineUtils", package: "Platform"),
            ]),
    ]
)
