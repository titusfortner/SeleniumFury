# -*- encoding: utf-8 -*-
require File.expand_path('../lib/selenium_fury/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Titus Fortner"]
  gem.email         = ["titusfortner@gmail.com"]
  gem.description   = %q{Ruby DSL for Selenium Webdriver}
  gem.summary       = %q{Helper methods for interacting with elements}
  gem.homepage      = "https://github.com/titusfortner/SeleniumFury"
  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "selenium_fury"
  gem.require_paths = ["lib"]
  gem.version       = SeleniumFury::VERSION
  gem.license       = "Apache 2.0"
  gem.add_dependency('selenium-webdriver','~> 2.0')
  gem.add_dependency('activesupport','~> 4.0')
  gem.add_development_dependency('rspec','~>2.12')
  gem.add_development_dependency('cucumber')
  gem.add_development_dependency('redcarpet')
  gem.add_development_dependency('rake')
  gem.add_development_dependency('json', '~> 1.7.7')
  gem.add_development_dependency('parallel_tests')
end
