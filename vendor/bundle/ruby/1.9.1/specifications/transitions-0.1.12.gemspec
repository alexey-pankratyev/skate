# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "transitions"
  s.version = "0.1.12"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jakub Kuzma", "Timo Roessner"]
  s.date = "2013-11-30"
  s.description = "Lightweight state machine extracted from ActiveModel"
  s.email = "timo.roessner@googlemail.com"
  s.homepage = "http://github.com/troessner/transitions"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "transitions"
  s.rubygems_version = "1.8.24"
  s.summary = "State machine extracted from ActiveModel"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1"])
      s.add_development_dependency(%q<test-unit>, ["~> 2.5"])
      s.add_development_dependency(%q<mocha>, ["~> 0.11.0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<random_data>, [">= 0"])
      s.add_development_dependency(%q<appraisal>, [">= 0"])
      s.add_development_dependency(%q<activerecord>, ["<= 4.0", ">= 3.0"])
    else
      s.add_dependency(%q<bundler>, ["~> 1"])
      s.add_dependency(%q<test-unit>, ["~> 2.5"])
      s.add_dependency(%q<mocha>, ["~> 0.11.0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<random_data>, [">= 0"])
      s.add_dependency(%q<appraisal>, [">= 0"])
      s.add_dependency(%q<activerecord>, ["<= 4.0", ">= 3.0"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1"])
    s.add_dependency(%q<test-unit>, ["~> 2.5"])
    s.add_dependency(%q<mocha>, ["~> 0.11.0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<random_data>, [">= 0"])
    s.add_dependency(%q<appraisal>, [">= 0"])
    s.add_dependency(%q<activerecord>, ["<= 4.0", ">= 3.0"])
  end
end
