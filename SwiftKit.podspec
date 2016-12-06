Pod::Spec.new do |spec|
    spec.name             = "SwiftKit"
    spec.version          = "0.1.0"
    spec.summary          = "SwiftKit is a collection of simple libraries that make your life easier."
    spec.description      = <<-DESC
                       SwiftKit's main purpose is to jumpstart iOS app development. We strive to deliver multiple small libraries that will solve the most basic things so you will not have to do it yourself.
                       DESC
    spec.homepage         = "https://github.com/SwiftKit/SwiftKit"
    spec.license          = 'MIT'
    spec.author           = { "Tadeas Kriz" => "tadeas@brightify.org", "Filip Dolnik" => "filip@brightify.org" }
    spec.source           = {
        :git => "https://github.com/SwiftKit/SwiftKit.git",
        :tag => spec.version.to_s
    }
    spec.social_media_url = 'https://twitter.com/BrightifyOrg'
    spec.platform     = :ios, '9.0'
    spec.requires_arc = true

    spec.source_files = ['SwiftKit/**/*.swift']

    spec.frameworks = 'Foundation'
    spec.dependency 'SwiftKit/DataMapper'
    spec.dependency 'Alamofire', '~> 4.0'
    spec.dependency 'HTTPStatusCodes', '~> 3.1'
    spec.dependency 'SwiftyJSON'
end
