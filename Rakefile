require 'bundler'
Bundler::GemHelper.install_tasks

require 'rake'
require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

# rake yard
require 'yard'
require 'yard/rake/yardoc_task'
YARD::Rake::YardocTask.new do |t|
  t.files   = ['lib/**/*.rb', 'README.md']
  t.options = ['--readme', 'README.md']
end

task :default => :test
