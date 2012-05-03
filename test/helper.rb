require 'rubygems'
require 'bundler/setup'

if Bundler.definition.specs['ruby-debug19'].first or Bundler.definition.specs['ruby-debug'].first
  require 'ruby-debug'
end

require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/reporters'
MiniTest::Unit.runner = MiniTest::SuiteRunner.new
MiniTest::Unit.runner.reporters << MiniTest::Reporters::SpecReporter.new

unless RUBY_VERSION >= '1.9'
  require 'fastercsv'
end

require 'errata'
