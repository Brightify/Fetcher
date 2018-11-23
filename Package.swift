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
        .package(url: "https://github.com/Quick/Nimble.git", from: "7.0.1"),
        .package(url: "https://github.com/Quick/Quick.git", from: "1.1.0"),
    ],
    targets: [
        .target(
            name: "Fetcher",
            dependencies: ["Alamofire", "RxSwift", "Result", "DataMapper"],
            path: "Source"),
        .testTarget(
            name: "FetcherTests",
            dependencies: ["Fetcher", "Alamofire", "RxSwift", "Result", "DataMapper", "Quick", "Nimble"],
            path: "Tests"),
    ]
)
