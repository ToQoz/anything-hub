# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'anything-hub/version'

Gem::Specification.new do |gem|
  gem.name          = "anything-hub"
  gem.version       = AnythingHub::VERSION
  gem.authors       = ["Takatoshi Matsumoto"]
  gem.email         = ["toqoz403@gmail.com"]
  gem.description   = %q{Anything interface for github}
  gem.summary       = %q{Anything interface for github. Filter response of Github api with anything interface and open selected one in browser.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'ruby-anything'
  gem.add_dependency 'slop'
  gem.add_dependency 'octokit'
  gem.add_dependency 'activesupport'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'vcr'
  gem.add_development_dependency 'webmock'
end
