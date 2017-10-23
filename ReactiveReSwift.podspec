Pod::Spec.new do |s|
  s.name              = "ReactiveReSwift"
  s.version           = "4.0.0"
  s.summary           = "Unidirectional Data Flow in Swift - Inspired by ReSwift and Elm"
  s.homepage          = "https://github.com/ReSwift/ReactiveReSwift"
  s.license           = 'MIT'
  s.license           = { :type => "MIT", :file => "LICENSE.md" }
  s.documentation_url = "https://reswift.github.io/ReactiveReSwift"
  s.author            = {
    "Charlotte Tortorella" => "charlotte@monadic.consulting"
  }
  s.source            = {
    :git => "https://github.com/ReSwift/ReactiveReSwift.git",
    :tag => s.version.to_s
  }

  s.ios.deployment_target     = '8.0'
  s.osx.deployment_target     = '10.10'
  s.tvos.deployment_target    = '9.0'
  s.watchos.deployment_target = '2.0'

  s.requires_arc = true
  s.source_files = 'Sources/**/*.swift'
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }
end
