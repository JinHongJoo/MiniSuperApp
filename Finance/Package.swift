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
            name: "AddPaymentMethodImp",
            targets: ["AddPaymentMethodImp"]),
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
            name: "FinanceRepositoryTestSupport",
            targets: ["FinanceRepositoryTestSupport"]),
        .library(
            name: "Topup",
            targets: ["Topup"]),
        .library(
            name: "TopupImp",
            targets: ["TopupImp"]),
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
                .product(name: "RIBsUtils", package: "Platform"),
            ]),
        .target(
            name: "AddPaymentMethodImp",
            dependencies: [
                "AddPaymentMethod",
                "FinanceEntity",
                "FinanceRepository",
                "ModernRIBs",
                "SnapKit",
                .product(name: "SuperUI", package: "Platform"),
                .product(name: "RIBsUtils", package: "Platform"),
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
                "TopupImp",
            ]),
        .target(
            name: "FinanceRepository",
            dependencies: [
                "FinanceEntity",
                .product(name: "CombineUtils", package: "Platform"),
                .product(name: "Network", package: "Platform"),
            ]),
        .target(
            name: "FinanceRepositoryTestSupport",
            dependencies: [
                "FinanceEntity",
                "FinanceRepository",
                .product(name: "CombineUtils", package: "Platform"),
            ]),
        .target(
            name: "Topup",
            dependencies: [
                "ModernRIBs",
            ]),
        .target(
            name: "TopupImp",
            dependencies: [
                "AddPaymentMethod",
                "FinanceRepository",
                "Topup",
                "ModernRIBs",
                .product(name: "CombineUtils", package: "Platform"),
                .product(name: "SuperUI", package: "Platform"),
            ]),
        .testTarget(
            name: "TopupImpTests",
            dependencies: [
                "TopupImp",
                "FinanceRepositoryTestSupport"
            ]),
    ]
)
