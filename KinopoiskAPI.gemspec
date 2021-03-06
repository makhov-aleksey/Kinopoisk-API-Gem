# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'KinopoiskAPI/version'

Gem::Specification.new do |spec|
  spec.name          = 'KinopoiskAPI'
  spec.version       = KinopoiskAPI::VERSION
  spec.authors       = ['Alexey Vildyaev']
  spec.email         = ['hav0k@me.com']

  spec.summary       = %q{Gem for operation with Kinopoisk API}
  spec.description   = %q{Gem is based on the mobile API}
  spec.homepage      = 'https://github.com/alpha-ver/Kinopoisk-API-Gem'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  # spec.bindir        = "exe"
  # spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  # spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
