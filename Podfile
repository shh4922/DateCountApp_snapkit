platform :ios, '14.1'

target 'DateCountApp_snapkit' do
  use_frameworks!
	pod 'SnapKit', '~> 5.0.0'

	pod 'FirebaseAnalytics'
	pod 'FirebaseAuth'
	pod 'FirebaseDatabase'
	pod 'FirebaseFirestore'
	pod 'FirebaseCore'
	pod 'Firebase'
	pod 'GoogleUtilities', :modular_headers => true
	pod 'NVActivityIndicatorView'
end
post_install do |installer|
 installer.pods_project.targets.each do |target|
  target.build_configurations.each do |config|
   config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.1'
  end
 end
end
