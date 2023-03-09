// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Platform",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "SuperUI",
            targets: ["SuperUI"]),
        .library(
            name: "RIBsUtils",
            targets: ["RIBsUtils"]),
        .library(
            name: "CombineUtils",
            targets: ["CombineUtils"]),
    ],
    dependencies: [
        .package(url: "https://github.com/DevYeom/ModernRIBs.git", from: "1.0.2"),
        .package(url: "https://github.com/CombineCommunity/CombineExt.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "SuperUI",
            dependencies: [
                "RIBsUtils"
            ]),
        .target(
            name: "RIBsUtils",
            dependencies: [
                "ModernRIBs"
            ]),
        .target(
            name: "CombineUtils",
            dependencies: [
                "CombineExt"
            ])
    ]
)
