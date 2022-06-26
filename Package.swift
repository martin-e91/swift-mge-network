// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "MGENetwork",
  platforms: [
		.iOS(.v13), .macOS(.v10_15)
  ],
  products: [
    .library(name: "MGENetwork", targets: ["MGENetwork"]),
  ],
  dependencies: [
    .package(url: "https://github.com/martin-e91/MGELogger.git", .exact("0.8.0"))
  ],
  targets: [
    .target(name: "MGENetwork", dependencies: ["MGELogger"]),
    .testTarget(name: "MGENetworkTests", dependencies: ["MGENetwork"]),
  ]
)
