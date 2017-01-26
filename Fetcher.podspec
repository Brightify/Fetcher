Pod::Spec.new do |spec|
    spec.name             = "Fetcher"
    spec.version          = "0.1.0"
    spec.summary          = "TODO"
    spec.description      = <<-DESC
                       TODO 2
                       DESC
    spec.homepage         = "https://github.com/Brightify/Fetcher"
    spec.license          = 'MIT'
    spec.author           = { "Tadeas Kriz" => "tadeas@brightify.org", "Filip Dolnik" => "filip@brightify.org" }
    spec.source           = {
        :git => "https://github.com/Brightify/Fetcher.git",
        :tag => spec.version.to_s
    }
    spec.social_media_url = 'https://twitter.com/BrightifyOrg'
    spec.platform     = :ios, '8.0'
    spec.requires_arc = true

    spec.source_files = ['Source/**/*.swift']

    spec.frameworks = 'Foundation'

    spec.dependency 'Brightify/DataMapper'
    spec.dependency 'Alamofire', '~> 4.0'
    spec.dependency 'HTTPStatusCodes', '~> 3.1'
end
