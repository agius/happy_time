# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "happy_time/version"

Gem::Specification.new do |spec|
  spec.name          = "happy_time"
  spec.version       = HappyTime::VERSION
  spec.authors       = ["agius"]
  spec.email         = ["andrew@atevans.com"]
  spec.summary       = %q{Tools to make dealing with Time in Rails easier.}
  spec.description   = %q{Tools to make dealing with Time in Rails easier.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activemodel", ">= 0"
  spec.add_dependency "activesupport"
  spec.add_dependency "tzinfo"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", ">= 0"
end
