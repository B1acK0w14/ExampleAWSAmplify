# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def general_pods
  pod 'SnapKit'
end

target 'ExampleAWSAmplify' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ExampleAWSAmplify
  general_pods
  pod 'AWSMobileClient', '~> 2.13.0'      # Required dependency
  pod 'AWSAuthUI', '~> 2.13.0'            # Optional dependency required to use drop-in UI
  pod 'AWSUserPoolsSignIn', '~> 2.13.0'   # Optional dependency required to use drop-in UI
end
