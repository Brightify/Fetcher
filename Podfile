source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

def shared
    pod 'Alamofire', '~> 4.8'
    pod 'RxSwift', '~> 5.0'
    pod 'DataMapper', :git => 'https://github.com/Brightify/DataMapper.git', :branch => 'preview/1.0.0'
end

target 'Fetcher' do
    shared
end

target 'FetcherTests' do
    shared
    pod 'Nimble', '~> 7.0'
    pod 'Quick', '~> 1.1'
end
