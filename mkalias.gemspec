# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mkalias/version'

Gem::Specification.new do |spec|
  spec.name          = "mkalias"
  spec.version       = Mkalias::VERSION
  spec.authors       = ["Luciano Prestes Cavalcanti"]
  spec.email         = ["lucianopcbr@gmail.com"]

  spec.summary       = %q{An make alias}
  spec.description   = %q{Make alias on yours command line}
  spec.homepage      = "https://github.com/LucianoPC/mkalias"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://github.com/LucianoPC/mkalias"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.executables << 'run'
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
