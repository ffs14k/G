Pod::Spec.new do |s|

  s.ios.deployment_target    = '10.0'
  s.tvos.deployment_target   = '10.0'
  s.name                     = "G"
  s.version                  = "0.1"
  s.summary                  = "G is a Generic Grid (table/collection) system"
  s.requires_arc             = true

  s.description  = <<-DESC
  G is a Generic Grid (table/collection) system which. Version for iOS/TVOS.
                   DESC

  s.homepage     = "https://github.com/FinchMoscow/FNetworkService"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author       = { "Eugene" => "orexjeka@icloud.com" }

  s.source       = { :git => "https://github.com/ffs14k/G.git", :tag => "#{s.version}" }

  s.source_files = "G/**/*.{swift}"

  s.exclude_files = "GTests/"

  s.swift_version = "5"

end

