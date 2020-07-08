Pod::Spec.new do |s|

  s.ios.deployment_target    = '10.0'
  s.tvos.deployment_target   = '10.0'
  s.name                     = "G"
  s.version                  = "0.2"
  s.summary                  = "Generic Grid |table/collection| system"
  s.requires_arc             = true

  s.description  = <<-DESC
  Generic Grid |table/collection| system which. Version for iOS/TVOS.
                   DESC

  s.homepage     = "https://github.com/ffs14k/G.git"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author       = { "Eugene" => "orexjeka@icloud.com" }

  s.source       = { :git => "https://github.com/ffs14k/G.git", :tag => "#{s.version}" }

  s.source_files = "G/Sources/**/*.{swift}"

  s.swift_version = "5"

end