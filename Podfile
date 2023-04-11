# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

target 'WrapItUpPayments' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for WrapItUpPayments
  pod 'SquarePointOfSaleSDK'
  pod 'Firebase/Core'
  pod 'FirebaseUI'
  pod 'FirebaseUI/Storage'

#  target 'WrapItUpPaymentsUITests' do
#    inherit! :search_paths
#    # Pods for testing
#  end

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
            end
        end
    end
end

end
