source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.3'

use_frameworks!

def app
    pod 'SDWebImage', '~> 3.0'
    pod 'QuadratTouch', '>= 1.0'
    pod 'INTULocationManager', '~> 4.0'
    pod 'Result', '~> 2.0'
    pod 'SwiftyJSON', '~> 2.0'
    pod 'NYTPhotoViewer', '~> 1.1.0'
end

def tests
    pod 'KIF', '~> 3.4.2'
    pod 'Nimble', '~> 3.2.0'
    pod 'Nocilla', '~> 0.10.0'
end

target 'FoursquareTop' do
    app
end

target 'FoursquareTopUITests' do
    app
    tests
end
