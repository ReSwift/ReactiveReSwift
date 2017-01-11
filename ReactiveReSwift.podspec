Pod::Spec.new do |s|
  s.name             = "ReactiveReSwift"
  s.summary          = "Unidirectional Data Flow in Swift - Inspired by ReSwift and Elm"
  s.version          = "3.0.1"
  s.license          = 'MIT'
  s.homepage         = "https://github.com/ReSwift/ReactiveReSwift"
  s.author           = { "Benjamin Encz" => "me@benjamin-encz.de" }
  s.source           = {
    :git => "https://github.com/vadymmarkov/ReactiveReSwift",
    :tag => s.version.to_s
  }

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.tvos.deployment_target = '9.2'

  s.requires_arc = true
  s.source_files = 'Sources/**/*.swift'
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3.0' }
end
