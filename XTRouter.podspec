Pod::Spec.new do |s|
  s.name             = 'XTRouter'
  s.version          = '1.2.0'
  s.summary          = 'a Powerful iOS Router'
  s.description      = '一个灵活的路由组件, 可以通过与web端协作跳转. 任意启动, 任意跳转,任意传参, 回调等.'

                       
  s.homepage         = 'https://github.com/akateason/XTRouter'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'teason' => 'akateason@qq.com' }
  s.source           = { :git => 'https://github.com/akateason/XTRouter.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.source_files = 'XTRouter/XTRouter'  
  s.public_header_files = 'XTRouter/XTRouter/*.h'  
  s.dependency 'XTBase'
  s.dependency 'XTFMDB'
end
