#
# Be sure to run `pod lib lint dsemeryc2019.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'dsemeryc2019'
  s.version          = '0.1.0'
  s.summary          = 'CoreDataSwiftPiscinePod'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description  = <<-DESC
  This pod is created as part of Swift Piscine School42(d08). It is about using CoreData.Unit Factory (Kiev) 2019'
 					 DESC
  s.homepage         = 'https://github.com/denis_semerych@icloud.com/'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'dsemeryc' => 'denis_semerych@icloud.com' }
  s.source           = { :git => 'https://github.com/denis_semerych@icloud.com/dsemeryc2019.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'dsemeryc2019/Classes/**/*.swift'
  s.swift_version = '4.0' 
  # spec.resource_bundles = {
  #   'dsemeryc2019' => ['dsemeryc2019/Assets/*.png']
  # }

  # spec.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'MapKit', 'CoreData'
  s.resources = 'dsemeryc2019/CoreData/**/*.xcdatamodeld'
  # spec.dependency 'AFNetworking', '~> 2.3'
end
