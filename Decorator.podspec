# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Decorator'
  s.version          = '2.0.0'
  s.summary          = 'Decorator style swizzle.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/DanboDuan/Decorator'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'DanboDuan' => 'bob170731@gmail.com' }
  s.source           = { :git => 'https://github.com/DanboDuan/Decorator.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.source_files = 'Decorator/**/*.{h,m}'

  s.public_header_files = 'Decorator/Decorator.h','Decorator/PureDecorator.h'
end
