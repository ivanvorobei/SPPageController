Pod::Spec.new do |s|

  s.name = 'SPPageController'
  s.version = '1.3.3'
  s.summary = 'Mimicrate to UIPageViewController. Has native system and scroll view paging. Support scroll to page and layout margins from container.'
  s.homepage = 'https://github.com/ivanvorobei/SPPageController'
  s.source = { :git => 'https://github.com/ivanvorobei/SPPageController.git', :tag => s.version }
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author = { 'Ivan Vorobei' => 'hello@ivanvorobei.io' }
  
  s.swift_version = '5.1'
  s.ios.deployment_target = '12.0'

  s.source_files = 'Sources/SPPageController/**/*.swift'

end
