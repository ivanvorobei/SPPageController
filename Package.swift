// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "SPPageController",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "SPPageController",
            targets: ["SPPageController"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SPPageController",
            swiftSettings: [
                .define("SPPAGECONTROLLER_SPM")
            ]
        )
    ],
    swiftLanguageVersions: [.v5]
)

