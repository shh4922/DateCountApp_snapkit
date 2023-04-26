
platform :ios, '14.0'

target 'DateCountApp_snapkit' do

pod 'SnapKit', '~> 5.0.0'

pod 'FirebaseAnalytics'
pod 'FirebaseAuth'
pod 'FirebaseFirestore'
pod 'Firebase'
pod 'FirebaseCore'
pod 'FirebaseDatabase'

#pod 'Firebase/Analytics'
#pod 'Firebase/Auth'

#firebase가 설치가 안되서 밑에작성해주니까 됌.. ㅋ
pod 'GoogleUtilities', :modular_headers => true
pod 'FirebaseCore', :modular_headers => true

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
      end
    end
end
