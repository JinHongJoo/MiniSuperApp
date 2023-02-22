# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'MiniSuperApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'ModernRIBs'
  pod 'SnapKit'
  # Pods for MiniSuperApp

  target 'MiniSuperAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'MiniSuperAppUITests' do
    # Pods for testing
  end
  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
      end
    end
  end

end
