// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VaccinationUI",
    defaultLocalization: "en",
    platforms: [.iOS(.v12)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "VaccinationUI",
            targets: ["VaccinationUI"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(path: "../VaccinationCommon"),
        .package(name: "BottomPopup", url: "https://github.com/ergunemr/BottomPopup.git", from: "0.6.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "VaccinationUI",
            dependencies: ["VaccinationCommon", "BottomPopup"],
            resources: [.process("Resources")]),
        .testTarget(
            name: "VaccinationUITests",
            dependencies: ["VaccinationUI"]),
    ]
)