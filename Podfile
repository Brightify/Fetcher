source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

def shared
    pod 'Alamofire', '~> 4.3'
    pod 'RxSwift', '~> 3.0'
    pod 'Result', '~> 3.0'
    pod 'DataMapper', '~> 0.1'
end

target 'Fetcher' do
    shared
end

target 'FetcherTests' do
    shared
    pod 'Nimble', '~> 5.0'
    pod 'Quick', '~> 1.0'
end
