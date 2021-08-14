// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "MGENetwork",
  platforms: [
    .iOS(.v9)
  ],
  products: [
    // Products define the executables and libraries produced by a package, and make them visible to other packages.
    .library(name: "MGENetwork", targets: ["MGENetwork"]),
  ],
  dependencies: [
    .package(url: "git@github.com:martin-e91/MGELogger.git", from: "0.8.0")
  ],
  targets: [
    .target(name: "MGENetwork", dependencies: ["MGELogger"]),
    .testTarget(name: "MGENetworkTests", dependencies: ["MGENetwork", "MGELogger"]),
  ]
)
