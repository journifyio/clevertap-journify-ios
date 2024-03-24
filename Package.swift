// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CleverTapDestination",
    platforms: [
        .iOS("13.0"),
        .tvOS("11.0"),
        .watchOS("7.1")
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "CleverTapDestination",
            targets: ["CleverTapDestination"]),
    ],
    dependencies: [
        .package(
	    name: "Journify",
            url: "https://github.com/journifyio/journify-ios-sdk.git",
            from: "0.0.6"
        ),
	.package(
	    name: "CleverTapSDK",
            url: "https://github.com/CleverTap/clevertap-ios-sdk.git",
            from: "6.1.0"
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "CleverTapDestination",
            dependencies: ["Journify", "CleverTapSDK"]
		),
        
        // TESTS ARE HANDLED VIA THE EXAMPLE APP.
    ]
)

