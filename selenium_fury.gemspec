# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{selenium_fury}
  s.version = "0.5.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Scott Sims}]
  s.date = %q{2011-07-27}
  s.description = %q{Generate and validate page objects with this page object factory for Selenium.}
  s.email = %q{ssims98@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  s.files = [
    ".rvmrc",
    "CHANGELOG",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE",
    "README.md",
    "Rakefile",
    "features/custom_generator.feature",
    "features/generate_page_object.feature",
    "features/step_definitions/custom_generator_steps.rb",
    "features/step_definitions/generate_page_object_steps.rb",
    "features/step_definitions/validate_page_object_steps.rb",
    "features/support/env.rb",
    "features/support/hooks.rb",
    "features/validate_page_object.feature",
    "lib/selenium_fury.rb",
    "lib/selenium_fury/create_browser_driver.rb",
    "lib/selenium_fury/custom_generator.rb",
    "lib/selenium_fury/page_generator.rb",
    "lib/selenium_fury/page_validator.rb",
    "selenium_fury.gemspec",
    "spec/advanced_search.rb",
    "spec/advanced_search_custom_generator_configuration.rb",
    "spec/advanced_search_spec.rb",
    "spec/custom_generators_spec.rb",
    "spec/page_generator_spec.rb",
    "spec/page_validator_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = %q{https://github.com/scottcsims/SeleniumFury}
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{Selenium Fury allows an automated tester to quickly build page files to use in the page object pattern.  Each page file represents a page under test with attributes of all the locators selenium needs to run tests on the page and methods that represent actions that can be performed on the page.  You use the generator to build the page files. After the page has been updated you can use the validator to go through all of the selenium locators you are using in your page file and return a list of the locators that it could not find. If there are missing locators you can then rerun the generator to generate new selenium locators for your page. http://www.scottcsims.com}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<bundler>, [">= 0"])
      s.add_runtime_dependency(%q<builder>, [">= 0"])
      s.add_runtime_dependency(%q<rake>, [">= 0"])
      s.add_runtime_dependency(%q<rspec>, [">= 0"])
      s.add_runtime_dependency(%q<selenium-client>, [">= 0"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 0"])
      s.add_runtime_dependency(%q<cucumber>, [">= 0"])
      s.add_development_dependency(%q<yard>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
      s.add_development_dependency(%q<rdiscount>, [">= 0"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 0"])
    else
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<builder>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<selenium-client>, [">= 0"])
      s.add_dependency(%q<nokogiri>, [">= 0"])
      s.add_dependency(%q<cucumber>, [">= 0"])
      s.add_dependency(%q<yard>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<rdiscount>, [">= 0"])
      s.add_dependency(%q<nokogiri>, [">= 0"])
    end
  else
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<builder>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<selenium-client>, [">= 0"])
    s.add_dependency(%q<nokogiri>, [">= 0"])
    s.add_dependency(%q<cucumber>, [">= 0"])
    s.add_dependency(%q<yard>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<rdiscount>, [">= 0"])
    s.add_dependency(%q<nokogiri>, [">= 0"])
  end
end

