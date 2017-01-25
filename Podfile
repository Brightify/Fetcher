source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

def shared
    pod 'Alamofire', '~> 4.3'
    pod 'RxSwift'
    pod 'Result'
    pod 'DataMapper', '~> 0.1'
end

target 'SwiftKit' do
    shared
end

target 'SwiftKitTests' do
    shared
    pod 'Nimble', '~> 5.0'
    pod 'Quick',  :git => 'https://github.com/Quick/Quick.git', :commit => '5e38179a69efd3601dea91c8825b9c35c28f9357'
end
