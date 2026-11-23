// swift-tools-version: 6.0
import PackageDescription

// Resolved via RN's build/generated/autolinking/libs/TikTokBusiness alias.
// The bridge depends on Swift; Swift never imports the bridge target.
let package = Package(
    name: "TikTokBusiness",
    platforms: [.iOS("15.1")],
    products: [
        .library(name: "TikTokBusiness", targets: ["TikTokBusiness", "TikTokBusinessImplementation"]),
    ],
    dependencies: [
        .package(name: "ReactNative", path: "../../../../xcframeworks"),
        .package(url: "https://github.com/tiktok/tiktok-business-ios-sdk.git", exact: "1.7.1"),
    ],
    targets: [
        .target(
            name: "TikTokBusinessImplementation",
            dependencies: [
                .product(name: "ReactHeaders", package: "ReactNative"),
                .product(name: "ReactNativeHeaders", package: "ReactNative"),
                .product(name: "ReactNativeDependenciesHeaders", package: "ReactNative"),
                .product(name: "TikTokBusinessSDK", package: "tiktok-business-ios-sdk"),
            ],
            path: "ios",
            exclude: ["TikTokBusinessModule.mm", "TikTokBusinessModule-Bridging-Header.h", "SPM"],
            sources: ["TikTokBusinessModule.swift"],
            swiftSettings: [.swiftLanguageMode(.v5)],
            linkerSettings: [.linkedFramework("UIKit")]
        ),
        .target(
            name: "TikTokBusiness",
            dependencies: [
                "TikTokBusinessImplementation",
                .product(name: "ReactHeaders", package: "ReactNative"),
                .product(name: "ReactNativeHeaders", package: "ReactNative"),
                .product(name: "ReactNativeDependenciesHeaders", package: "ReactNative"),
            ],
            path: "ios",
            exclude: ["TikTokBusinessModule.swift", "TikTokBusinessModule-Bridging-Header.h"],
            sources: ["TikTokBusinessModule.mm"],
            publicHeadersPath: "SPM/include",
            linkerSettings: [.linkedFramework("Foundation"), .unsafeFlags(["-ObjC"])]
        ),
    ],
    cxxLanguageStandard: .cxx20
)
