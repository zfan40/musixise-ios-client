

platform :ios, '8.0'

post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['CLANG_ENABLE_OBJC_WEAK'] ||= 'YES'
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '8.0'
            if config.name == 'Release'
                config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= ['$(inherited)', 'NDEBUG=1']
            end
        end
    end
end

def pods

pod 'MYUtils', :path => './LocalPods/MYUtils/'
pod 'MYIconFont', :path => './LocalPods/MYIconFont/'
pod 'MYImageService', :path => './LocalPods/MYImageService/'
pod 'MYMVVM', :path => './LocalPods/MYMVVM/'
pod 'MYNetwork', :path => './LocalPods/MYNetwork/'
pod 'MYUtils', :path => './LocalPods/MYUtils/'
pod 'MYWidget', :path => './LocalPods/MYWidget/'
pod 'MYAudio', :path => './LocalPods/MYAudio/'
pod 'MYUserSystem', :path => './LocalPods/MYUserSystem/'
pod 'WebViewJavascriptBridge', :path => './LocalPods/WebViewJavascriptBridge/'
pod 'MYThirdKit', :path => './LocalPods/MYThirdKit/'
pod 'MYShare', :path => './LocalPods/MYShare/'
pod 'AFNetworking',:path => './LocalPods/AFNetworking/'
pod 'JSONModel',:path => './LocalPods/JSONModel/'
pod 'MJRefresh',:path => './LocalPods/MJRefresh/'
pod 'Reachability',:path => './LocalPods/Reachability/'
pod 'SDWebImage',:path => './LocalPods/SDWebImage/'

end
target ‘musixise’ do
  pods
end
