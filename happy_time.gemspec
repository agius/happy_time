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

  spec.files         = Dir["{app,config,db,lib}/**/*"] + ["LICENSE.txt", "Rakefile", "README.md"]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 3.2.11"

  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "timecop"
end
