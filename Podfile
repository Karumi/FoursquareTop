source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.3'

use_frameworks!

def app
    pod 'SDWebImage', '~> 3.0'
    pod 'QuadratTouch', git:"https://github.com/Karumi/das-quadrat.git", branch:"swift2.3"
    pod 'INTULocationManager', '~> 4.0'
    pod 'Result', '~> 2.0'
    pod 'SwiftyJSON', git:"https://github.com/TheSufferfest/SwiftyJSON.git", branch:"master"
    pod 'NYTPhotoViewer', '~> 1.1.0'
end

def tests
    pod 'KIF', '~> 3.4.2'
    pod 'Nimble', '~> 3.2.0'
end

target 'FoursquareTop' do
    app
end

target 'FoursquareTopUITests' do
    app
    tests
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '2.3'
            if target.name == 'KIF'
                config.build_settings['ENABLE_BITCODE'] = 'NO'
            end
        end
    end
end