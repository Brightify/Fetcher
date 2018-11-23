// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "Fetcher",
    products: [
        .library(
            name: "Fetcher",
            targets: ["Fetcher"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", "4.0.0"..<"5.0.0"),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", "4.0.0"..<"5.0.0"),
        .package(url: "https://github.com/antitypical/Result.git", "4.0.0"..<"5.0.0"),
        .package(url: "https://github.com/Brightify/DataMapper.git", .branch("feature/swift-pm")),
    ],
    targets: [
        .target(
            name: "Fetcher",
            dependencies: ["Alamofire", "RxSwift", "Result", "DataMapper"],
            path: "Source"),
        .testTarget(
            name: "FetcherTests",
            dependencies: ["Fetcher", "Alamofire", "RxSwift", "Result", "DataMapper"],
            path: "Tests"),
    ]
)
