# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mkalias/version'

Gem::Specification.new do |spec|
  spec.name          = 'mkalias'
  spec.version       = Mkalias::VERSION
  spec.authors       = ['Luciano Prestes Cavalcanti']
  spec.email         = ['lucianopcbr@gmail.com']

  spec.summary       = 'A program to create bash alias'
  spec.description   = 'MKalias is a bash alias manage, when you can just' \
                       ' add a command and you can add a new alias, list' \
                       ' the alias, show the alias command or remove the' \
                       ' alias.'
  spec.homepage      = 'https://github.com/LucianoPC/mkalias'
  spec.license       = 'Expat'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir = 'bin'
  spec.executables << 'mkalias'
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
