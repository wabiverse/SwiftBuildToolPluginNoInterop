// swift-tools-version: 5.9
import PackageDescription

let package = Package(
  name: "SwiftBuildToolPluginNoInterop",
  platforms: [
    .macOS(.v14),
    .visionOS(.v1),
    .iOS(.v17),
    .tvOS(.v17),
    .watchOS(.v10),
  ],
  products: [
    // Products define the executables and libraries a package produces, making them visible to other packages.
    .plugin(
      name: "GenerateUmbrellaHeadersPlugin",
      targets: ["GenerateUmbrellaHeadersPlugin"]
    ),

    .library(
      name: "CxxModule",
      targets: ["CxxModule"]
    ),

    .executable(
      name: "SwiftPluginNoInterop",
      targets: ["SwiftPluginNoInterop"]
    ),
  ],
  targets: [
    // Targets are the basic building blocks of a package, defining a module or a test suite.
    // Targets can depend on other targets in this package and products from dependencies.
    .plugin(
      name: "GenerateUmbrellaHeadersPlugin",
      capability: .buildTool()
    ),

    .target(
      name: "CxxModule",
      plugins: [
        .plugin(name: "GenerateUmbrellaHeadersPlugin"),
      ]
    ),

    .executableTarget(
      name: "SwiftPluginNoInterop",
      dependencies: [
        .target(name: "CxxModule"),
      ],
      swiftSettings: [
        .interoperabilityMode(.Cxx)
      ]
    ),
  ]
)
