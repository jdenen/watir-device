# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'watir-device/version'

Gem::Specification.new do |spec|
  spec.name          = "watir-device"
  spec.version       = Watir::WatirDevice::VERSION
  spec.authors       = ["Johnson Denen"]
  spec.email         = ["johnson.denen@gmail.com"]

  spec.summary       = %q{Automate Chrome Developer Tools' device emulation with watir-webdriver}
  spec.description   = %q{Automate Chrome Developer Tools' device emulation with watir-webdriver}
  spec.homepage      = "https://github.com/jdenen/watir-device"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "watir-webdriver", "~> 0.8.0"
  
  spec.add_development_dependency "bundler", ">= 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "simplecov", "~> 0.10"
end
