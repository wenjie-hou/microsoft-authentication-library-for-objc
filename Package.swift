// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "Microsoft Authentication Library for Objective-C",
    products: [
        .library(
            name: "microsoft-authentication-library-for-objc",
            targets: ["MSAL"]),
    ],
    targets: [
        .binaryTarget(
            name: "MSAL",
            url: "https://github.com/wenjie-hou/microsoft-authentication-library-for-objc/releases/download/1.1.14-beta.1/MSAL.xcframework.zip",
            checksum: "0171cd9d8f21e07deb7e801d0cf82cf8e6ae42db1ce19935115ad5490853d0b7"
            )
    ]
)
