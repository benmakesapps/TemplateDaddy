// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "Navigation",
    platforms: [.iOS(.v18)],
    products: [
        .library(name: "Navigation", targets: ["Navigation"]),
    ],
    targets: [
        .target(name: "Navigation"),
    ]
)
