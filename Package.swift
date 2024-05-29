// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AlertMaster",
      platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "AlertMaster",
            targets: ["AlertMaster"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
        .package(url: "https://github.com/moslienko/AppViewUtilits.git", from: "1.2.6")
    ],
    targets: [
        .target(
            name: "AlertMaster",
            dependencies: ["AppViewUtilits"]
        ),
        .testTarget(
            name: "AlertMasterTests",
            dependencies: ["AlertMaster"]),
    ]
)
