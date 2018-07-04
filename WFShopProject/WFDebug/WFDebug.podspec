#
# Be sure to run `pod lib lint WFDebug.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WFDebug'
  s.version          = '0.1.0'
  s.summary          = 'A short description of WFDebug.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/andysheng@live.com/WFDebug'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'andysheng@live.com' => 'andysheng@live.com' }
  s.source           = { :git => 'https://github.com/andysheng@live.com/WFDebug.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'WFDebug/Classes/**/*'
  
  s.resource_bundles = {
    'WFDebug' => ['WFDebug/Assets/**/*.{png,xcassets,xib,storyboard,plist}']
  }

  s.dependency 'ADSRouter'
  s.dependency 'Masonry'
  s.dependency 'SDWebImage'
  s.dependency 'WFUIComponent'
  s.dependency 'YYModel'
  s.dependency 'PPNumberButton'
  s.dependency 'WFNetwork'
  s.dependency 'MBProgressHUD'
  s.dependency 'MJExtension'
  s.dependency 'HCSStarRatingView'
  s.dependency 'MJRefresh'
end
