# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{errata}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Seamus Abshere", "Andy Rossmeissl"]
  s.date = %q{2010-05-05}
  s.description = %q{Correct strings based on remote errata files}
  s.email = %q{seamus@abshere.net}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "errata.gemspec",
     "lib/errata.rb",
     "lib/erratum.rb",
     "lib/erratum/delete.rb",
     "lib/erratum/reject.rb",
     "lib/erratum/replace.rb",
     "lib/erratum/simplify.rb",
     "lib/erratum/transform.rb",
     "lib/erratum/truncate.rb",
     "test/errata_test.rb",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/seamusabshere/errata}
  s.rdoc_options = ["--charset=UTF-8", "--line-numbers", "--inline-source"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{errata}
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Correct strings based on remote errata files}
  s.test_files = [
    "test/errata_test.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 2.3.4"])
      s.add_development_dependency(%q<remote_table>, [">= 0.2.19"])
    else
      s.add_dependency(%q<activesupport>, [">= 2.3.4"])
      s.add_dependency(%q<remote_table>, [">= 0.2.19"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 2.3.4"])
    s.add_dependency(%q<remote_table>, [">= 0.2.19"])
  end
end

