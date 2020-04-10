// swift-tools-version:5.2

import PackageDescription

let version = ( major: 3, minor: 1, patch: 4 )

let package = Package(
    name: "Olm",
    products: [
        .library(name: "libolm", targets: ["libolm"])
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
        )
    ],
    cLanguageStandard: .c99,
    cxxLanguageStandard: .cxx11
)
