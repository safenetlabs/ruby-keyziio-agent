# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'keyziio/version'

Gem::Specification.new do |spec|
  spec.name          = 'keyziio'
  spec.version       = Keyziio::VERSION
  spec.authors       = ['Russ Egan']
  spec.email         = ['russ@keyzi.io']
  spec.summary       = 'A ruby API wrapper around the keyziio server REST API.'
  # spec.description   =
  spec.homepage      = 'https://github.com/safenetlabs/node-keyziio-agent'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'rest-client'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest'
end
