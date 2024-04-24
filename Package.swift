// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "IGListKit",
    platforms: [ 
        .iOS(.v15)
    ],
    products: [
        .library(name: "IGListDiffKit",
                 targets: ["IGListDiffKit"]),
        .library(name: "IGListKit",
                 targets: ["IGListKit"]),
        .library(name: "IGListSwiftKit",
                 targets: ["IGListSwiftKit"]),
    ],
    targets: [
        .target(
            name: "IGListDiffKit",
            path: "spm/Sources/IGListDiffKit",
            resources: [.copy("PrivacyInfo.xcprivacy")],
            publicHeadersPath: "include"
        ),
        .target(
            name: "IGListKit",
            dependencies: ["IGListDiffKit"],
            path: "spm/Sources/IGListKit",
            resources: [.copy("PrivacyInfo.xcprivacy")],
            publicHeadersPath: "include"
        ),
        .target(
            name: "IGListSwiftKit",
            dependencies: ["IGListKit"],
            path: "spm/Sources/IGListSwiftKit",
            resources: [.copy("PrivacyInfo.xcprivacy")]
        ),
    ],
    cLanguageStandard: .c11,
    cxxLanguageStandard: .cxx11
)
