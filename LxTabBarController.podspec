Pod::Spec.new do |s|
  s.name         = "LxTabBarController"
  s.version      = "1.0.0"
  s.summary      = "Change UITabBarController interactive mode"

  s.homepage     = "https://github.com/DeveloperLx/LxTabBarController"
  s.license      = 'Apache'
  s.authors      = { 'DeveloperLx' => 'developerlx@yeah.com' }
  s.platform     = :ios, "7.0"
  s.ios.deployment_target = "7.0"
  s.source       = { :git => "https://github.com/DeveloperLx/LxTabBarController.git", :tag => s.version}
  s.source_files = 'LxTabBarController/LxTabBarController.*'
  s.requires_arc = true
  s.frameworks   = 'Foundation', 'UIKit'
end
