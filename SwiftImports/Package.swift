// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "SwiftImports",
  platforms: [
    .macOS(.v10_13)
  ],
  products: [
    .executable(name: "swiftimports", targets: ["SwiftImports"])
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-argument-parser", .upToNextMinor(from: "0.4.0")),
    .package(name: "SwiftSyntax", url: "https://github.com/apple/swift-syntax.git", .exact("0.50300.0")),
    .package(url: "https://github.com/Quick/Nimble.git", .upToNextMajor(from: "8.0.1")),
    .package(url: "https://github.com/Quick/Quick.git", .upToNextMajor(from: "3.0.0")),
  ],
  targets: [
    .target(
      name: "SwiftImports",
      dependencies: [
        .target(name: "SwiftImportsCore"),
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
      ]),
    .target(
      name: "SwiftImportsCore",
      dependencies: ["SwiftSyntax"]),
    .testTarget(
      name: "SwiftImportsCoreTests",
      dependencies: [
        .target(name: "SwiftImportsCore"),
        "Nimble",
        "Quick",
      ]),
  ]
)
