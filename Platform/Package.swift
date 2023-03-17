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
        .library(
            name: "DefaultsStore",
            targets: ["DefaultsStore"]),
        .library(
            name: "Network",
            targets: ["Network"]),
        .library(
            name: "NetworkImp",
            targets: ["NetworkImp"]),
    ],
    dependencies: [
        .package(url: "https://github.com/DevYeom/ModernRIBs.git", from: "1.0.2"),
        .package(url: "https://github.com/CombineCommunity/CombineExt.git", from: "1.0.0"),
        .package(url: "https://github.com/pointfreeco/combine-schedulers", from: "0.5.3")
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
                "CombineExt",
                .product(name: "CombineSchedulers", package: "combine-schedulers")
            ]),
        .target(
            name: "DefaultsStore",
            dependencies: [
            ]),
        .target(
            name: "Network",
            dependencies: [
            ]),
        .target(
            name: "NetworkImp",
            dependencies: [
                "Network"
            ])
        
    ]
)
