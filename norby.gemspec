# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'norby/version'

Gem::Specification.new do |spec|
  spec.name          = 'norby'
  spec.version       = Norby::VERSION
  spec.authors       = ['Islam Wazery']
  spec.email         = ['wazery@ubuntu.com']

  spec.summary       = 'A simple robot simulator written in Ruby'
  spec.description   = 'A simple robot simulator written in Ruby'
  spec.homepage      = 'https://www.github.com/wazery/norby'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = ['norby']
  spec.require_paths = ['lib']

  spec.add_dependency 'colorize'
  spec.add_dependency 'thor'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rspec'
end
