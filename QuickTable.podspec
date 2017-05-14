#
# Be sure to run `pod lib lint QuickTable.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'QuickTable'
  s.version          = '0.1.1'
  s.summary          = 'A quicker way to build TableViews'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
The goal is to provide a robust UITableView solution which provides a clean and easy to read format.

Some TableView implementations, especially settings screens, can use a variety of cells and section ranging from dynamic
to static.  The goal is to offer a clean solution for quickly building these views while providing an easy to maintain
solution.  Settings screens change during a product lifecycle, adding a row here or a section there should not be an
extrodenary feat of if / else statements.
                       DESC

  s.homepage         = 'https://github.com/kgellci/QuickTable'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'kgellci' => 'kgellci@gmail.com' }
  s.source           = { :git => 'https://github.com/kgellci/QuickTable.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/kgellci'

  s.ios.deployment_target = '8.0'

  s.source_files = 'QuickTable/Classes/**/*'
  
  # s.resource_bundles = {
  #   'QuickTable' => ['QuickTable/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
