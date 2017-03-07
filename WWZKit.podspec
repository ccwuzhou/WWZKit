#
#  Be sure to run `pod spec lint WWZKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "WWZKit"
  s.version      = "1.0.3"
  s.summary      = "A short description of WWZKit."

    # s.description  = <<-DESC
  #                  DESC

  s.homepage     = "https://github.com/ccwuzhou/WWZKit"

  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  s.author             = { "wwz" => "wwz@zgkjd.com" }

  s.platform     = :ios

  s.ios.deployment_target = "8.0"

  s.source       = { :git => "https://github.com/ccwuzhou/WWZKit.git", :tag => "#{s.version}"}

  # s.public_header_files  = "WWZKit/WWZKit.h"

  # s.source_files = "WWZKit/WWZKit.h"

  s.requires_arc = true

  s.framework  = "UIKit"
  # s.default_subspecs = 'Model'

  s.subspec 'Model' do |ss|
    ss.source_files = "WWZKit/Model/*.{h,m}"
  end
  s.subspec 'Controller' do |ss|
    ss.source_files = "WWZKit/Controller/*.{h,m}"
  end
  s.subspec 'View' do |ss|
    ss.source_files = "WWZKit/View/*.{h,m}"
    ss.dependency "WWZKit/Model"
  end
  s.subspec 'Cell' do |ss|
    ss.source_files = "WWZKit/Cell/*.{h,m}"
  end
  s.subspec 'UIKit' do |ss|
    ss.source_files = "WWZKit/UIKit+WWZ/*.{h,m}"
  end
end
