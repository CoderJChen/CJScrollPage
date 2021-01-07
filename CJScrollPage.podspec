#
# Be sure to run `pod lib lint CJScrollPage.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CJScrollPage'
  s.version          = '1.0.17'
  s.summary          = '快速灵活的集成类似网易新闻, 头条等带滑块的滚动视图,实现视图联动, 滑块.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
页面轮播选择器
                       DESC

  s.homepage         = 'https://github.com/CoderJChen/CJScrollPage'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'coderCJ' => 'zhiyi_eric@163.com' }
  s.source           = { :git => 'https://github.com/CoderJChen/CJScrollPage.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'CJScrollPage/*'
#  s.subspec 'ScrollPage' do |ss|
#      ss.source_files = 'CJScrollPage/CJMenuBarShowDetailVC.{h,m}','CJScrollPage/CJMenuCell.{h,m}','CJScrollPage/CJScrollPageConst.{h,m}','CJScrollPage/CJSegmentBar.{h,m}','CJScrollPage/CJSegmentBarConfig.{h,m}','CJScrollPage/CJSegmentModelProtocol.{h,m}','CJScrollPage/CJSegmentRLButton.{h,m}','CJScrollPage/NSString+SegmentModelProtocol.{h,m}','CJScrollPage/UIView+CJExtension.{h,m}','CJScrollPage/CJSegmentViewController.{h,m}'
#    end
   s.resource_bundles = {
     'CJScrollPage' => ['CJScrollPage/*.{png,xib,storyboard}']
   }

#   s.public_header_files = 'CJScrollPage/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
