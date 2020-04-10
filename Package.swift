// swift-tools-version:5.2

import PackageDescription

let version = ( major: 3, minor: 1, patch: 4 )

let package = Package(
    name: "Olm",
    products: [
        .library(name: "libolm", targets: ["libolm"]),
        .library(name: "OLMKit", targets: ["OLMKit"]),
    ],
    targets: [
        .target(
            name: "libolm",
            path: ".",
            sources: [ "src" ],
            publicHeadersPath: "include",
            cSettings: [
              .define("OLMLIB_VERSION_MAJOR", to: String(version.major)),
              .define("OLMLIB_VERSION_MINOR", to: String(version.minor)),
              .define("OLMLIB_VERSION_PATCH", to: String(version.patch)),
              .headerSearchPath("lib"),
              .unsafeFlags([ "-Wall", "-Werror" ])
            ]
        ),
        .target(
            name: "OLMKit",
            dependencies: [ "libolm" ],
            path: "xcode",
            sources: [ "OLMKit" ],
            publicHeadersPath: "OLMKit",
            cSettings: [
              .headerSearchPath("."),
              .unsafeFlags([ 
                "-Wno-unused-command-line-argument",
                "-fmodules", "-fcxx-modules"
              ])
            ]
        )
    ],
    cLanguageStandard: .c99,
    cxxLanguageStandard: .cxx11
)
