# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bases/version'

Gem::Specification.new do |spec|
  spec.name          = 'bases'
  spec.version       = Bases::VERSION
  spec.authors       = ['Andrea Leopardi']
  spec.email         = 'an.leopardi@gmail.com'
  spec.summary       = 'Convert bases like a mofo.'
  spec.homepage      = 'https://github.com/whatyouhide/bases'
  spec.license       = 'MIT'
  spec.description   = <<-DESC
    This gem lets you convert integers from and to whatever base you like. You
    can use array bases where you specify all the digits in the base,
    multicharacter digits and other niceties.  By default, this gem avoids
    monkeypatching core Ruby classes, but it can be configured to monkeypatch
    too.
  DESC

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  # This gem works for Ruby >= 1.9.3.
  spec.required_ruby_version = '>= 1.9.3'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake', '~> 10'
  spec.add_development_dependency 'minitest', '~> 5'
  spec.add_development_dependency 'minitest-reporters', '~> 1.0'
  spec.add_development_dependency 'coveralls', '~> 0.7'
end
