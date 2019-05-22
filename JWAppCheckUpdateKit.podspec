#
# Be sure to run `pod lib lint JWAppCheckUpdateKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JWAppCheckUpdateKit'
  s.version          = '0.1.3'
  s.summary          = '提示app更新'
  s.homepage         = 'https://github.com/jw10126121/JWAppCheckUpdateKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'jw10126121' => '10126121@qq.com' }
  s.source           = { :git => 'https://github.com/jw10126121/JWAppCheckUpdateKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'JWAppCheckUpdateKit/Classes/**/*'
  s.swift_versions = ['4.2', '5.0'] # 同时支持4.2和5.0
  
  #s.dependency 'XBDialog', '~> 1.6.0'
end
