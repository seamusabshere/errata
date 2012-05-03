# -*- encoding: utf-8 -*-
require File.expand_path("../lib/errata/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "errata"
  s.version     = Errata::VERSION
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
  s.add_dependency 'remote_table', '>=1.1.7'
  s.add_dependency 'to_regexp', '>= 0.0.2'
end
