Pod::Spec.new do |s|
  s.name             = 'StanwoodUITesting'
  s.version          = '0.2.0'
  s.summary          = 'Stanwood iOS UITesting Tool'
  s.description      = <<-DESC
Stanwood iOS UITesting tool
                       DESC

  s.homepage         = 'https://github.com/stanwood/STWUITestingKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Tal Zion' => 'tal.zion@stanwood.io' }
  s.source           = { :git => 'https://github.com/stanwood/STWUITestingKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.swift_version = '3.3'
  
  s.source_files = 'StanwoodUITesting/Classes/**/*'
  s.frameworks = 'XCTest'
end
