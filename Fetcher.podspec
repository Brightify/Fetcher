Pod::Spec.new do |spec|
    spec.name             = "Fetcher"
    spec.version          = "1.0.0-alpha.1"
    spec.summary          = "Swift HTTP networking library."
    spec.description      = <<-DESC
                       Fetcher is a small HTTP networking library for Swift. Its main goal is to simplify common tasks like sending REST requests. Networking is a very complex subject and our goal is not to cover everything that can be done. But we provide API that allows you to implement what you need or to customize behavior of Fetcher (this is handy if your server for some reason does not obey any standard).
                       DESC
    spec.homepage         = "https://github.com/Brightify/Fetcher"
    spec.license          = 'MIT'
    spec.author           = {
        "Tadeas Kriz" => "tadeas@brightify.org",
        "Filip Dolnik" => "filip@brightify.org",
        "Matyas Kriz" => "matyas@brightify.org"
    }
    spec.source           = {
        :git => "https://github.com/Brightify/Fetcher.git",
        :tag => spec.version.to_s
    }
    spec.social_media_url = 'https://twitter.com/BrightifyOrg'
    spec.requires_arc = true
    spec.swift_version = '5.0'

    spec.ios.deployment_target = '8.0'
    spec.osx.deployment_target = '10.11'

    spec.frameworks = 'Foundation'

    spec.subspec 'Core' do |subspec|
        subspec.dependency 'DataMapper', '~> 1.0'
        subspec.source_files = 'Source/Core/**/*.swift'
    end

    spec.subspec 'AlamofireRequestPerformer' do |subspec|
        subspec.dependency 'Fetcher/Core'
        subspec.dependency 'Alamofire', '~> 4.8'
        subspec.source_files = 'Source/AlamofireRequestPerformer/**/*.swift'
    end

    spec.subspec 'RxFetcher' do |subspec|
        subspec.dependency 'Fetcher/Core'
        subspec.dependency 'RxSwift', '~> 4.0'
        subspec.source_files = 'Source/RxFetcher/**/*.swift'
    end

    spec.default_subspecs = 'Core', 'AlamofireRequestPerformer'
end
