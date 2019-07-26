source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

def shared
    pod 'Alamofire', '~> 4.3'
    pod 'RxSwift', '~> 4.0'
    pod 'DataMapper'
end

target 'Fetcher' do
    shared
end

target 'FetcherTests' do
    shared
    pod 'Nimble', '~> 7.0'
    pod 'Quick', '~> 1.1'
end
