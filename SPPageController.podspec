Pod::Spec.new do |s|

  s.name = 'SPPageController'
  s.version = '1.0.0'
  s.summary = 'Mimicrate to native UIPageViewController. Each page is new controller.'
  s.homepage = 'https://github.com/ivanvorobei/SPPageController'
  s.source = { :git => 'https://github.com/ivanvorobei/SPPageController.git', :tag => s.version }
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author = { 'Ivan Vorobei' => 'hello@ivanvorobei.by' }
  
  s.swift_version = '5.1'
  s.ios.deployment_target = '12.0'

  s.source_files = 'Sources/SPPageController/**/*.swift'

end
