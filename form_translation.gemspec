# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'form_translation/version'

Gem::Specification.new do |spec|
  spec.name          = "form_translation"
  spec.version       = FormTranslation::VERSION
  spec.authors       = ["Florian Thomas"]
  spec.email         = ["flo@florianthomas.net"]
  spec.description   = %q{Include fields for multiple languages in your forms.}
  spec.summary       = %q{Include fields for multiple languages in your forms.}
  spec.homepage      = "https://github.com/Crunch09/form_translation"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "sqlite3"
  spec.add_dependency "rails", "~>  4.0.0"
  spec.add_dependency "simple_form", "~> 3.0.0"
end
