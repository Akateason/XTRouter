Pod::Spec.new do |s|
  s.name             = 'XTRouter'
  s.version          = '0.0.1'
  s.summary          = 'A short description of XTRouter.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC
  s.homepage         = 'https://github.com/akateason/XTRouter'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'teason' => 'akateason@qq.com' }
  s.source           = { :git => 'https://github.com/akateason/XTRouter.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'XTRouter/Classes/**/*'

  # s.resource_bundles = {
  #   'XTRouter' => ['XTRouter/Assets/*.png']
  # }

  #s.subspec 'XTRouter' do | sm |
      #sm.source_files = 'XTRouter/ZYSubModule/**/*'
      #sm.dependency 'AFNetworking', '~> 2.3'
  #end

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
