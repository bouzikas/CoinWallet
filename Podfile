# global platform
platform :ios, '12.0'

install! 'cocoapods', :warn_for_unused_master_specs_repo => false

# required pods for running the app
def required
  pod 'Alamofire'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'lottie-ios'
  pod 'SkeletonView'
end

# required pods for developing the app
def required_dev
  required
end

# silent pod warnings
inhibit_all_warnings!

target 'CoinWlt' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for CoinWlt
  required
  
  target 'CoinWltTests' do
    inherit! :search_paths
    # Pods for testing
    required_dev
  end

  target 'CoinWltUITests' do
    # Pods for testing
    required_dev
  end

end
