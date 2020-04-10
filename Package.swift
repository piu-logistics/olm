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
            sources: [ 
              "src",
              "lib/crypto-algorithms/aes.c",
              "lib/crypto-algorithms/sha256.c",
              "lib/curve25519-donna/curve25519-donna.c"
            ],
            //publicHeadersPath: "include",
            publicHeadersPath: "include/public",
            cSettings: [
                .define("OLMLIB_VERSION_MAJOR", to: String(version.major)),
                .define("OLMLIB_VERSION_MINOR", to: String(version.minor)),
                .define("OLMLIB_VERSION_PATCH", to: String(version.patch)),
                .headerSearchPath("lib"),
                .headerSearchPath("include"),
                .unsafeFlags([ "-Wall", "-Werror" ])
            ]
        ),
        .target(
            name: "OLMKit",
            dependencies: [ "libolm" ],
            path: "xcode",
            exclude: [ "OLMKit/Info.plist" ],
            sources: [ "OLMKit" ],
            publicHeadersPath: "PublicHeaders",
            cSettings: [
                .headerSearchPath("."),
                .unsafeFlags([
                    "-Wno-unused-command-line-argument",
                    "-fmodules", "-fcxx-modules"
                ])
            ]
        ),
        .testTarget(
            name: "OLMKitTests",
            dependencies: [ "OLMKit", "libolm" ],
            path: "xcode/OLMKitTests",
            cSettings: [
                .headerSearchPath(".."),
            ]
        )
    ],
    cLanguageStandard: .c99,
    cxxLanguageStandard: .cxx11
)
