require 'rubygems'
require 'bundler'
unless RUBY_VERSION >= '1.9'
  gem 'fastercsv'
  require 'fastercsv'
end
Bundler.setup
require 'test/unit'
require 'shoulda'
$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'errata'
class Test::Unit::TestCase
end
