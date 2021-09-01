// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "MGENetwork",
  platforms: [
    .iOS(.v9)
  ],
  products: [
    .library(name: "MGENetwork", targets: ["MGENetwork"]),
  ],
  dependencies: [
    .package(url: "https://github.com/martin-e91/MGELogger.git", .branch("develop"))
  ],
  targets: [
    .target(name: "MGENetwork", dependencies: ["MGELogger"], exclude: ["docs", "iOS Example", "generate_doc.sh"]),
    .testTarget(
      name: "MGENetworkTests",
      dependencies: ["MGENetwork"]),
  ]
)
