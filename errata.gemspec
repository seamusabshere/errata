# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "errata/version"

Gem::Specification.new do |s|
  s.name        = "errata"
  s.version     = Errata::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Seamus Abshere", "Andy Rossmeissl"]
  s.email       = ["seamus@abshere.net"]
  s.homepage    = "https://github.com/seamusabshere/errata"
  s.summary     = "Correct strings based on remote errata files"
  s.description = %q{Correct strings based on remote errata files.}

  s.rubyforge_project = "errata"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency 'activesupport', '>=2.3.4'
  s.add_dependency 'remote_table', '~>1'
  s.add_development_dependency 'test-unit'
  s.add_development_dependency 'shoulda'
  s.add_development_dependency 'ruby-debug'
end
