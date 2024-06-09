// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MELIAppData",
    platforms: [.iOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "MELIAppData",
            targets: ["MELIAppData"]),
    ],
    dependencies: [
        .package(path: "../../MELITechnicalTest/MELINetworking"),
        .package(path: "../../MELITechnicalTest/MELIAppDomain")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "MELIAppData",
            dependencies: [
                .product(name: "MELINetworking", package: "MELINetworking"),
                .product(name: "MELIAppDomain", package: "MELIAppDomain")
            ]),
        .testTarget(
            name: "MELIAppDataTests",
            dependencies: ["MELIAppData"]),
    ]
)
