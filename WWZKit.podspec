Pod::Spec.new do |s|
  s.name         = "WWZKit"
  s.version      = "1.1.9"
  s.summary      = "A short description of WWZKit."

  s.homepage     = "https://github.com/ccwuzhou/WWZKit"

  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  s.author             = { "wwz" => "wwz@zgkjd.com" }

  s.platform     = :ios

  s.ios.deployment_target = "8.0"

  s.source       = { :git => "https://github.com/ccwuzhou/WWZKit.git", :tag => "#{s.version}"}

  # s.public_header_files  = "WWZKit/WWZKit.h"

  s.source_files = "WWZKit/*.h"

  s.requires_arc = true

  s.framework  = "UIKit"
  # s.default_subspecs = 'Model'

  s.subspec 'UIKit+WWZ' do |ss|
    ss.source_files = "UIKit+WWZ/*.{h,m}"
  end
  s.subspec 'WWZKit' do |ss|
	 ss.subspec 'Model' do |sss|
    	sss.source_files = "WWZKit/Model/*.{h,m}"
  	end
  	ss.subspec 'Controller' do |sss|
    	sss.source_files = "WWZKit/Controller/*.{h,m}"
  	end
  	ss.subspec 'View' do |sss|
    	sss.source_files = "WWZKit/View/*.{h,m}"
    	sss.dependency "WWZKit/WWZKit/Model"
      sss.dependency "WWZKit/UIKit+WWZ"
  	end
  	ss.subspec 'Cell' do |sss|
    	sss.source_files = "WWZKit/Cell/*.{h,m}"
  	end
  end
  
  
end
