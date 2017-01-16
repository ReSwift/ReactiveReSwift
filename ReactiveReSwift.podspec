Pod::Spec.new do |s|
  s.name              = "ReactiveReSwift"
  s.version           = "3.0.2"
  s.summary           = "Unidirectional Data Flow in Swift - Inspired by ReSwift and Elm"
  s.homepage          = "https://github.com/ReSwift/ReactiveReSwift"
  s.license           = 'MIT'
  s.license           = { :type => "MIT", :file => "LICENSE.md" }
  s.documentation_url = "https://reswift.github.io/ReactiveReSwift"
  s.author            = {
    "Charlotte Tortorella" => "charlotte@monadic.consulting",
    "Karl Bowden" => "karl@bearded.sexy"
  }
  s.source            = {
    :git => "https://github.com/ReSwift/ReactiveReSwift",
    :tag => s.version.to_s
  }

  s.ios.deployment_target     = '8.0'
  s.osx.deployment_target     = '10.10'
  s.tvos.deployment_target    = '9.0'
  s.watchos.deployment_target = '2.0'

  s.requires_arc = true
  s.source_files = 'Sources/**/*.swift'
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3.0' }
end
